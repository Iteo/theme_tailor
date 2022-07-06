import 'dart:async';

import 'package:analyzer/dart/analysis/results.dart';
import 'package:analyzer/dart/ast/ast.dart';
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

    final classLevelEncoders = _computeEncoders(annotation);
    final classLevelAnnotations = <String>[];
    final fieldLevelAnnotations = <String, List<String>>{};

    final tailorClassVisitor = _TailorClassVisitor();
    element.visitChildren(tailorClassVisitor);
    final fields = tailorClassVisitor.fields;

    final fieldsToCheck =
        fields.values.where((f) => f.isTailorThemeExtension).map((f) => f.name);

    final astVisitor = _TailorClassASTVisitor(fieldNamesToCheck: fieldsToCheck);
    _getAstNodeFromElement(element).visitChildren(astVisitor);

    for (final typeEntry in astVisitor.fieldTypes.entries) {
      final fieldValue = fields[typeEntry.key];
      if (fieldValue != null) {
        fields[typeEntry.key] = fieldValue.copyWith(typeName: typeEntry.value);
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

    final config = ThemeClassConfig(
      fields: tailorClassVisitor.fields,
      className: stringUtil.themeClassName(className),
      baseClassName: className,
      themes: themes,
      themesFieldName: themeFieldName,
      encoderManager: encoderDataManager,
      themeGetter: themeGetter,
      annotationManager: annotationDataManager,
      isFlutterDiagnosticable: hasDiagnostics,
    );

    final generatorBuffer = StringBuffer()
      ..write(ThemeClassTemplate(config, stringUtil))
      ..write(ThemeExtensionTemplate(config, stringUtil));

    return generatorBuffer.toString();
  }

  List<String> _computeThemes(ConstantReader annotation) {
    return List<String>.from(
      annotation.read('themes').listValue.map((e) => e.toStringValue()),
    );
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
  final Map<String, Field> fields = {};
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};
  final Map<String, List<bool>> hasInternalAnnotations = {};

  final extensionAnnotationTypeChecker =
      TypeChecker.fromRuntime(themeExtension.runtimeType);

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
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
      );
    }
  }
}

class _TailorClassASTVisitor extends SimpleAstVisitor {
  _TailorClassASTVisitor({required this.fieldNamesToCheck});

  final List<String> rawClassAnnotations = [];
  final Map<String, List<String>> rawFieldsAnnotations = {};

  final Iterable<String> fieldNamesToCheck;
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
      final childTypeEntities =
          fieldType.childEntities.map((e) => e.toString()).toList();
      if (childTypeEntities.length >= 2 && childTypeEntities[0] == 'List') {
        final typeWithBraces = childTypeEntities[1];
        fieldTypes[fieldName] =
            typeWithBraces.substring(1, typeWithBraces.length - 1);
      }
    }
  }
}

AstNode _getAstNodeFromElement(Element element) {
  final library = element.library!;
  final result = library.session.getParsedLibraryByElement(library)
      as ParsedLibraryResult?;
  return result!.getElementDeclaration(element)!.node;
}
