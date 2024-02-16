// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/ast/token.dart';
import 'package:analyzer/dart/ast/visitor.dart';
import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/generator_for_annotated_class.dart';
import 'package:theme_tailor/src/model/annotation_data_manager.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/library_data.dart';
import 'package:theme_tailor/src/model/tailor_annotation_data.dart';
import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/template/theme_class_template.dart';
import 'package:theme_tailor/src/template/context_extension_template.dart';
import 'package:theme_tailor/src/util/extension/contant_reader_extension.dart';
import 'package:theme_tailor/src/util/extension/dart_type_extension.dart';
import 'package:theme_tailor/src/util/extension/element_annotation_extension.dart';
import 'package:theme_tailor/src/util/extension/element_extension.dart';
import 'package:theme_tailor/src/util/extension/field_declaration_extension.dart';
import 'package:theme_tailor/src/util/extension/library_element_extension.dart';
import 'package:theme_tailor/src/util/field_helper.dart';
import 'package:theme_tailor/src/util/string_format.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class TailorGenerator
    extends GeneratorForAnnotatedClass<ImportsData, TailorAnnotationData, ThemeClassConfig, TailorMixin> {
  const TailorGenerator(this.buildYamlConfig);

  final TailorMixin buildYamlConfig;

  @override
  ClassElement ensureClassElement(Element element) {
    if (element is ClassElement && element is! Enum) return element;

    throw InvalidGenerationSourceError(
      'Tailor can only annotate classes',
      element: element,
      todo: 'Move @TailorMixin annotation above `class`',
    );
  }

  @override
  ImportsData parseLibraryData(LibraryElement library, ClassElement element) {
    return ImportsData(
      hasJsonSerializable: element.hasJsonSerializableAnnotation,
      hasDiagnosticableMixin: library.hasFlutterDiagnosticableImport,
    );
  }

  @override
  TailorAnnotationData parseAnnotation(ConstantReader annotation) {
    return TailorAnnotationData(
      themes: annotation.getFieldOrElse(
        'themes',
        decode: (o) => null,
        orElse: () => ['light', 'dark'],
      ),
      themeGetter: annotation.getFieldOrElse(
        'themeGetter',
        decode: (o) => ThemeGetter.values.byName(o.revive().accessor.split('.').last),
        orElse: () => buildYamlConfig.themeGetter ?? ThemeGetter.onBuildContextProps,
      ),
      themeClassName: annotation.getFieldOrElse(
        'themeClassName',
        decode: (o) => o.stringValue,
        orElse: () => buildYamlConfig.themeClassName ?? 'Theme',
      ),
      themeDataClassName: annotation.getFieldOrElse(
        'themeDataClassName',
        decode: (o) => o.stringValue,
        orElse: () => buildYamlConfig.themeDataClassName,
      ),
      encoders: _typeToThemeEncoderDataFromAnnotation(annotation),
    );
  }

  @override
  ThemeClassConfig parseData(
    ImportsData libraryData,
    TailorAnnotationData annotationData,
    ClassElement element,
  ) {
    const fmt = StringFormat();
    final classLevelEncoders = annotationData.encoders;
    final classLevelAnnotations = <String>[];
    final fieldLevelAnnotations = <String, List<String>>{};

    final tailorClassVisitor = _TailorClassVisitor(
      requireConstThemes: false,
      generateStaticGetters: false,
    );
    element.visitChildren(tailorClassVisitor);
    final fields = tailorClassVisitor.fields;

    final fieldsToCheck =
        fields.values.where((f) => f.isTailorThemeExtension || f.type == 'dynamic').map((f) => f.name);

    final typeDefAstVisitor = _TypeDefAstVisitor();

    final library = element.library;
    for (final unit in _getLibrariesCompilationUnits([library, ...library.importedLibraries])) {
      unit.visitChildren(typeDefAstVisitor);
    }

    final astVisitor = _TailorClassASTVisitor(
      fieldNamesToCheck: fieldsToCheck.toList(),
      typeDefinitions: typeDefAstVisitor.typeDefinitions,
    );
    final classAstNode = _getAstNodeFromElement(element);
    classAstNode.visitChildren(astVisitor);

    for (final typeEntry in astVisitor.fieldTypes.entries) {
      fields[typeEntry.key]?.type = typeEntry.value;
    }

    final fieldInitializerVisitor = _TailorFieldInitializerVisitor(
      themeCount: annotationData.themes.length,
      fieldsToCheck: tailorClassVisitor.fields.keys.toList(),
    );
    if (!tailorClassVisitor.hasNonConstantElement) {
      classAstNode.visitChildren(fieldInitializerVisitor);

      if (fieldInitializerVisitor.hasValuesForAllFields) {
        for (final fieldName in fieldInitializerVisitor.fieldValues.keys) {
          final values = fieldInitializerVisitor.fieldValues[fieldName];
          fields[fieldName]?.values = values;
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

      if (!annotation.isTailorAnnotation && !annotation.isSourceGenAnnotation) {
        classLevelAnnotations.add(astVisitor.rawClassAnnotations[i]);
      }
    }

    for (var entry in tailorClassVisitor.hasInternalAnnotations.entries) {
      if (entry.value.isEmpty) continue;

      final astAnnotations = <String>[];

      entry.value.forEachIndexed((i, isInternal) {
        if (!isInternal) {
          astAnnotations.add(astVisitor.rawFieldsAnnotations[entry.key]![i]);
        }
      });

      fieldLevelAnnotations[entry.key] = astAnnotations;
    }

    final generateConstantThemes =
        !tailorClassVisitor.hasNonConstantElement && fieldInitializerVisitor.hasValuesForAllFields;

    final sortedFields = Map.fromEntries(
      tailorClassVisitor.fields.entries.sorted(
        (a, b) => a.value.compareTo(b.value),
      ),
    );

    final themeFieldName = getFreeFieldName(
      fieldNames: fields.keys.toList(),
      proposedNames: ['themes', 'tailorThemes', 'tailorThemesList'],
      warningPropertyName: 'tailor theme list',
    );

    return ThemeClassConfig(
      fields: sortedFields,
      className: fmt.themeClassName(element.name),
      baseClassName: element.name,
      themes: annotationData.themes,
      themesFieldName: themeFieldName,
      encoderManager: ThemeEncoderManager(
        classLevelEncoders,
        tailorClassVisitor.fieldLevelEncoders,
      ),
      themeGetter: annotationData.themeGetter.extensionData,
      themeClassName: annotationData.themeClassName,
      themeDataClassName: annotationData.themeDataClassName,
      annotationManager: AnnotationDataManager(
        classAnnotations: classLevelAnnotations,
        fieldsAnotations: fieldLevelAnnotations,
      ),
      hasDiagnosticableMixin: libraryData.hasDiagnosticableMixin,
      hasJsonSerializable: libraryData.hasJsonSerializable,
      constantThemes: generateConstantThemes,
    );
  }

  @override
  void generateForData(StringBuffer buffer, ThemeClassConfig data) => buffer
    ..template(ThemeTailorTemplate(data, StringFormat()))
    ..template(ContextExtensionTemplate(
      data.className,
      data.themeGetter,
      data.fields.values.toList(),
      data.themeClassName,
      data.themeDataClassName,
    ));

  Map<String, ThemeEncoderData> _typeToThemeEncoderDataFromAnnotation(
    ConstantReader annotation,
  ) {
    return annotation.getFieldOrElse(
      'encoders',
      decode: (o) => Map.fromEntries(
        o.listValue
            .map((dartObject) => extractThemeEncoderData(null, dartObject))
            .whereType<ThemeEncoderData>()
            .map((encoderData) => MapEntry(encoderData.type, encoderData)),
      ),
      orElse: () => {},
    );
  }
}

class _TailorClassVisitor extends SimpleElementVisitor {
  _TailorClassVisitor({
    required this.requireConstThemes,
    required this.generateStaticGetters,
  });

  final bool requireConstThemes;
  final bool generateStaticGetters;

  final Map<String, TailorField> fields = {};
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};
  final Map<String, List<bool>> hasInternalAnnotations = {};
  var hasNonConstantElement = false;

  final extensionAnnotationTypeChecker = TypeChecker.fromRuntime(themeExtension.runtimeType);

  final ignoreAnnotationTypeChecker = TypeChecker.fromRuntime(ignore.runtimeType);

  @override
  void visitFieldElement(FieldElement element) {
    if (ignoreAnnotationTypeChecker.hasAnnotationOf(element)) return;

    if (element.isStatic && element.type.isDartCoreList) {
      if (!requireConstThemes && generateStaticGetters) {
        if (!element.isSynthetic && !element.isConst) {
          print(
            'Field "${element.name}" will not be updated on hot reload, since it is neither a getter nor a const.',
          );
        }
      }

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

      final implementsThemeExtension = hasThemeExtensionAnnotation || coreType.isThemeExtensionType;

      hasInternalAnnotations[propName] = isInternalAnnotation;

      fields[propName] = TailorField(
        name: propName,
        type: coreType.getDisplayString(withNullability: true),
        isThemeExtension: implementsThemeExtension,
        isTailorThemeExtension: hasThemeExtensionAnnotation,
        documentation: element.documentationComment,
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
      final typeDefinitionChildEntities = typeDefinitions[node.fields.childEntities.first.toString()]?.childEntities;

      final childTypeEntities =
          (typeDefinitionChildEntities ?? fieldType.childEntities).map((e) => e.toString()).toList();
      if (childTypeEntities.length >= 2 && childTypeEntities[0] == 'List') {
        final typeWithBraces = childTypeEntities[1];
        fieldTypes[fieldName] = typeWithBraces.substring(1, typeWithBraces.length - 1);
      }
    }
  }
}

class _TailorFieldInitializerVisitor extends SimpleAstVisitor {
  _TailorFieldInitializerVisitor({
    required this.themeCount,
    required this.fieldsToCheck,
  });

  final int themeCount;
  final List<String> fieldsToCheck;

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

        if (!containsBrackets && [TokenType.OPEN_SQUARE_BRACKET, TokenType.CLOSE_SQUARE_BRACKET].contains(token.type)) {
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

        if (token.type == TokenType.OPEN_PAREN || token.type == TokenType.OPEN_SQUARE_BRACKET) {
          parenthesis++;
        }

        if (token.type == TokenType.CLOSE_PAREN || token.type == TokenType.CLOSE_SQUARE_BRACKET) {
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

List<CompilationUnit> _getLibrariesCompilationUnits(List<LibraryElement> libraries) {
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
    typeDefinitions[node.name.toString().replaceAll('?', '')] = node.type;

    super.visitGenericTypeAlias(node);
  }
}
