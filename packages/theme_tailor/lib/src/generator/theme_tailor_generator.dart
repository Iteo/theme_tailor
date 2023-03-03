import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/annotation_data_manager.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';
import 'package:theme_tailor/src/template/theme_class_template.dart';
import 'package:theme_tailor/src/template/theme_extension_template.dart';
import 'package:theme_tailor/src/util/extension/dart_type_extension.dart';
import 'package:theme_tailor/src/util/extension/element_annotation_extension.dart';
import 'package:theme_tailor/src/util/extension/element_extension.dart';
import 'package:theme_tailor/src/util/extension/field_declaration_extension.dart';
import 'package:theme_tailor/src/util/extension/library_element_extension.dart';
import 'package:theme_tailor/src/util/field_helper.dart';
import 'package:theme_tailor/src/util/string_format.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor/src/util/theme_getter_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  ThemeTailorGenerator({required this.builderOptions});

  final BuilderOptions builderOptions;

  @override
  Future<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) async {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError(
        'Tailor can only annotate classes',
        element: element,
        todo: 'Move @Tailor annotation above `class`',
      );
    }
    final library = element.library;

    final hasDiagnostics = library.hasFlutterDiagnosticableImport;

    const stringUtil = StringFormat();

    final className = element.name;
    final themes = _computeThemes(annotation);

    final themeGetter = _computeThemeGetter(annotation);
    final requireConstThemes = annotation.read('requireStaticConst').boolValue;

    final classLevelEncoders = _computeEncoders(annotation);
    final classLevelAnnotations = <String>[];
    final fieldLevelAnnotations = <String, List<String>>{};

    final tailorClassVisitor = _TailorClassVisitor(
      requireConstThemes: requireConstThemes,
    );
    element.visitChildren(tailorClassVisitor);
    final fields = tailorClassVisitor.fields;

    final fieldsToCheck = fields.values
        .where((f) => f.isTailorThemeExtension || f.typeName == 'dynamic')
        .map((f) => f.name);

    final typeDefAstVisitor = _TypeDefAstVisitor();
    for (final unit in _getLibrariesCompilationUnits(
        [library, ...library.importedLibraries])) {
      unit.visitChildren(typeDefAstVisitor);
    }

    final astVisitor = _TailorClassASTVisitor(
      fieldNamesToCheck: fieldsToCheck.toList(),
      typeDefinitions: typeDefAstVisitor.typeDefinitions,
    );
    final classAstNode = _getAstNodeFromElement(element);
    classAstNode.visitChildren(astVisitor);

    for (final typeEntry in astVisitor.fieldTypes.entries) {
      final fieldValue = fields[typeEntry.key];
      if (fieldValue != null) {
        fields[typeEntry.key] = fieldValue.copyWith(typeName: typeEntry.value);
      }
    }

    final fieldInitializerVisitor = _TailorFieldInitializerVisitor(
      themeCount: themes.length,
      fieldsToCheck: tailorClassVisitor.fields.keys.toList(),
      requireConstThemes: requireConstThemes,
    );
    if (requireConstThemes || !tailorClassVisitor.hasNonConstantElement) {
      classAstNode.visitChildren(fieldInitializerVisitor);

      if (fieldInitializerVisitor.hasValuesForAllFields) {
        for (final fieldValueEntry
            in fieldInitializerVisitor.fieldValues.entries) {
          final fieldValue = fields[fieldValueEntry.key];
          if (fieldValue != null) {
            fields[fieldValueEntry.key] = fieldValue.copyWith(
                values:
                    fieldInitializerVisitor.fieldValues[fieldValueEntry.key]);
          }
        }
      }
    }

    for (var i = 0; i < element.metadata.length; i++) {
      final annotation = element.metadata[i];

      final encoder = extractThemeEncoderData(
        annotation,
        annotation.computeConstantValue()!,
      );

      if (encoder != null) {
        classLevelEncoders[encoder.type] = encoder;
        continue;
      }

      if (!annotation.isTailorAnnotation) {
        classLevelAnnotations.add(astVisitor.rawClassAnnotations[i]);
      }
    }

    for (var entry in tailorClassVisitor.hasInternalAnnotations.entries) {
      if (entry.value.isEmpty) continue;

      final astAnnotations = <String>[];

      entry.value.forEachIndexed((i, isInternal) {
        late final value = astVisitor.rawFieldsAnnotations[entry.key]![i];
        if (!isInternal) astAnnotations.add(value);
      });
      fieldLevelAnnotations[entry.key] = astAnnotations;
    }

    final encoderDataManager = ThemeEncoderDataManager(
      classLevelEncoders,
      tailorClassVisitor.fieldLevelEncoders,
    );

    final annotationDataManager = AnnotationDataManager(
      classAnnotations: classLevelAnnotations,
      fieldsAnotations: fieldLevelAnnotations,
      hasJsonSerializable: element.hasJsonSerializableAnnotation,
    );

    final themeFieldName = getFreeFieldName(
      fieldNames: fields.keys.toList(),
      proposedNames: [
        'themes',
        'tailorThemes',
        'tailorThemesList',
      ],
      warningPropertyName: 'tailor theme list',
    );

    final generateConstantThemes = requireConstThemes
        ? true
        : (!tailorClassVisitor.hasNonConstantElement &&
            fieldInitializerVisitor.hasValuesForAllFields);

    final sortedFields = Map.fromEntries(
      tailorClassVisitor.fields.entries.sorted(
        (a, b) => a.value.compareTo(b.value),
      ),
    );

    final config = ThemeClassConfig(
      fields: sortedFields,
      className: stringUtil.themeClassName(className),
      baseClassName: className,
      themes: themes,
      themesFieldName: themeFieldName,
      encoderManager: encoderDataManager,
      themeGetter: themeGetter,
      annotationManager: annotationDataManager,
      isFlutterDiagnosticable: hasDiagnostics,
      constantThemes: generateConstantThemes,
    );

    final generatorBuffer = StringBuffer()
      ..write(ThemeClassTemplate(config, stringUtil))
      ..write(ThemeExtensionTemplate(config, stringUtil));

    return generatorBuffer.toString();
  }

  List<String> _computeThemes(ConstantReader annotation) {
    if (!annotation.read('themes').isNull) {
      return annotation
          .read('themes')
          .listValue
          .map((e) => e.toStringValue())
          .whereNotNull()
          .toList();
    }

    var pubThemes = builderOptions.config['themes'] as List<dynamic>?;

    const defaultThemes = ['light', 'dark'];
    if (pubThemes == null) return defaultThemes;

    return pubThemes.whereNotNull().map((e) => e.toString()).toList();
  }

  ExtensionData _computeThemeGetter(ConstantReader annotation) {
    return themeGetterDataFromData(annotation.read('themeGetter'));
  }

  Map<String, ThemeEncoderData> _computeEncoders(ConstantReader annotation) {
    final encodersReader = annotation.read('encoders');
    final encoders = <String, ThemeEncoderData>{};
    if (encodersReader.isNull) return encoders;

    for (final object in encodersReader.listValue) {
      final encoderData = extractThemeEncoderData(null, object);
      if (encoderData != null) encoders[encoderData.type] = encoderData;
    }
    return encoders;
  }
}

class _TailorClassVisitor extends SimpleElementVisitor {
  _TailorClassVisitor({required this.requireConstThemes});

  final bool requireConstThemes;

  final Map<String, Field> fields = {};
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};
  final Map<String, List<bool>> hasInternalAnnotations = {};
  var hasNonConstantElement = false;

  final extensionAnnotationTypeChecker =
      TypeChecker.fromRuntime(themeExtension.runtimeType);

  final ignoreAnnotationTypeChecker =
      TypeChecker.fromRuntime(ignore.runtimeType);

  @override
  void visitFieldElement(FieldElement element) {
    if (ignoreAnnotationTypeChecker.hasAnnotationOf(element)) return;

    if (element.isStatic && element.type.isDartCoreList) {
      if (!element.isConst) {
        hasNonConstantElement = true;

        if (requireConstThemes) {
          throw InvalidGenerationSourceError(
            'Field "${element.name}" needs to be a const in order to be included',
            element: element,
            todo: 'Move this field const',
          );
        }
      }

      final propName = element.name;
      final isInternalAnnotation = <bool>[];

      var hasThemeExtensionAnnotation = false;

      for (final annotation in element.metadata) {
        if (annotation.isTailorThemeExtension) {
          isInternalAnnotation.add(true);
          hasThemeExtensionAnnotation = true;
          continue;
        }

        final encoderData = extractThemeEncoderData(
          annotation,
          annotation.computeConstantValue()!,
        );

        if (encoderData != null) {
          isInternalAnnotation.add(true);
          fieldLevelEncoders[propName] = encoderData;
        } else {
          isInternalAnnotation.add(false);
        }
      }

      final coreType = element.type.coreIterableGenericType;

      final implementsThemeExtension =
          hasThemeExtensionAnnotation || coreType.isThemeExtensionType;

      hasInternalAnnotations[propName] = isInternalAnnotation;

      fields[propName] = Field(
        name: propName,
        typeName: coreType.getDisplayString(withNullability: true),
        implementsThemeExtension: implementsThemeExtension,
        isTailorThemeExtension: hasThemeExtensionAnnotation,
        documentationComment: element.documentationComment,
      );
    }
  }
}

class _TailorClassASTVisitor extends SimpleAstVisitor {
  _TailorClassASTVisitor({
    required this.fieldNamesToCheck,
    required this.typeDefinitions,
  });

  final List<String> rawClassAnnotations = [];
  final Map<String, List<String>> rawFieldsAnnotations = {};

  final List<String> fieldNamesToCheck;
  final Map<String, TypeAnnotation> typeDefinitions;
  final Map<String, String> fieldTypes = {};

  @override
  void visitAnnotation(Annotation node) {
    rawClassAnnotations.add(node.toString());
  }

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    final fieldName = node.name;
    final fieldType = node.fields.type;

    rawFieldsAnnotations[fieldName] = node.annotations;

    if (fieldType != null && fieldNamesToCheck.contains(fieldName)) {
      final typeDefinitionChildEntities =
          typeDefinitions[node.fields.childEntities.first.toString()]
              ?.childEntities;

      final childTypeEntities =
          (typeDefinitionChildEntities ?? fieldType.childEntities)
              .map((e) => e.toString())
              .toList();
      if (childTypeEntities.length >= 2 && childTypeEntities[0] == 'List') {
        final typeWithBraces = childTypeEntities[1];
        fieldTypes[fieldName] =
            typeWithBraces.substring(1, typeWithBraces.length - 1);
      }
    }
  }
}

class _TailorFieldInitializerVisitor extends SimpleAstVisitor {
  _TailorFieldInitializerVisitor({
    required this.themeCount,
    required this.fieldsToCheck,
    required this.requireConstThemes,
  });

  final int themeCount;
  final List<String> fieldsToCheck;
  final bool requireConstThemes;

  final Map<String, List<String>> fieldValues = {};
  var hasValuesForAllFields = true;

  final _constKeyword = 'const';

  @override
  void visitFieldDeclaration(FieldDeclaration node) {
    final fieldName = node.name;
    if (!fieldsToCheck.contains(fieldName)) {
      return;
    }

    for (final variable in node.fields.variables) {
      final initializer = variable.initializer;
      if (initializer == null) {
        continue;
      }

      var token = initializer.beginToken.previous!;

      var stringValue = '';
      final values = <String>[];

      var parenthesis = -1;

      var containsBrackets = false;

      while (token.type != TokenType.SEMICOLON) {
        final next = token.next;
        if (next != null) {
          token = next;
        } else {
          break;
        }

        if (!containsBrackets &&
            [TokenType.OPEN_SQUARE_BRACKET, TokenType.CLOSE_SQUARE_BRACKET]
                .contains(token.type)) {
          containsBrackets = true;
        }

        if (parenthesis == -1 && token.type == TokenType.OPEN_SQUARE_BRACKET) {
          parenthesis++;
          continue;
        }

        if (parenthesis == 0 && token.type == TokenType.CLOSE_SQUARE_BRACKET) {
          if (stringValue.isNotEmpty) {
            values.add(stringValue.replaceAll(_constKeyword, ''));
          }
          break;
        }

        if (token.type == TokenType.OPEN_PAREN ||
            token.type == TokenType.OPEN_SQUARE_BRACKET) {
          parenthesis++;
        }

        if (token.type == TokenType.CLOSE_PAREN ||
            token.type == TokenType.CLOSE_SQUARE_BRACKET) {
          parenthesis--;
        }

        if (token.type == TokenType.COMMA && parenthesis == 0) {
          values.add(stringValue.replaceAll(_constKeyword, ''));
          stringValue = '';
        } else {
          stringValue += token.toString();
        }
      }

      if (values.length != themeCount) {
        hasValuesForAllFields = false;
        if (requireConstThemes) {
          if (values.isEmpty && !containsBrackets) {
            throw InvalidGenerationSourceError(
              'To generate constant theme, list value of "${node.name}" has to '
              'be defined in place',
              element: node.declaredElement2,
              todo: 'Move this field const',
            );
          } else {
            print('List length of "${node.name}" should match theme count');
          }
        }

        return;
      }

      fieldValues[fieldName] = values;
      break;
    }
  }
}

AstNode _getAstNodeFromElement(Element element) {
  final result = _getParsedLibraryResultFromElement(element);
  return result!.getElementDeclaration(element)!.node;
}

List<CompilationUnit> _getLibrariesCompilationUnits(
    List<LibraryElement> libraries) {
  return libraries
      .map(_getParsedLibraryResultFromElement)
      .whereNotNull()
      .map((lib) => lib.units.map((u) => u.unit))
      .flattened
      .toList();
}

ParsedLibraryResult? _getParsedLibraryResultFromElement(Element element) {
  final library = element.library;
  final parsedLibrary = library?.session.getParsedLibraryByElement(library);
  if (parsedLibrary is ParsedLibraryResult) {
    return parsedLibrary;
  } else {
    return null;
  }
}

class _TypeDefAstVisitor extends SimpleAstVisitor {
  final typeDefinitions = <String, TypeAnnotation>{};

  @override
  void visitGenericTypeAlias(GenericTypeAlias node) {
    typeDefinitions[node.name2.toString().replaceAll('?', '')] = node.type;

    super.visitGenericTypeAlias(node);
  }
}
