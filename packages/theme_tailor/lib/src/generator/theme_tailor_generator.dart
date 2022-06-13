import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:source_helper/source_helper.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_class_config.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/template/theme_class_template.dart';
import 'package:theme_tailor/src/template/theme_extension_template.dart';
import 'package:theme_tailor/src/util/iterable_helper.dart';
import 'package:theme_tailor/src/util/string_format.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor/src/util/theme_getter_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError(
        'Tailor can only annotate classes',
        element: element,
        todo: 'Move @Tailor annotation above `class`',
      );
    }

    const stringUtil = StringFormat();

    final className = element.name;
    final themes = SplayTreeSet<String>.from(annotation.read('themes').listValue.map((e) => e.toStringValue()));
    final themeGetter = themeGetterDataFromData(annotation.read('themeGetter'));

    final encodersReader = annotation.read('encoders');

    final classLevelEncoders = <String, ThemeEncoderData>{};

    if (!encodersReader.isNull) {
      for (final object in encodersReader.listValue) {
        final encoderData = extractThemeEncoderData(null, object);
        if (encoderData != null) {
          classLevelEncoders[encoderData.type] = encoderData;
        }
      }
    }

    for (final annotation in element.metadata) {
      final encoderData = extractThemeEncoderData(annotation, annotation.computeConstantValue()!);
      if (encoderData != null) {
        classLevelEncoders[encoderData.type] = encoderData;
      }
    }

    final tailorClassVisitor = _TailorClassVisitor(themes: themes);
    element.visitChildren(tailorClassVisitor);

    final config = ThemeClassConfig(
      fields: tailorClassVisitor.fields,
      returnType: stringUtil.themeClassName(className),
      baseClassName: className,
      themes: themes,
      encoderDataManager: ThemeEncoderDataManager(
        classLevelEncoders,
        tailorClassVisitor.fieldLevelEncoders,
      ),
      themeGetter: themeGetter,
    );

    final generatorBuffer = StringBuffer(
      ThemeClassTemplate(config, stringUtil),
    );
    ThemeExtensionTemplate(config, stringUtil).writeBuffer(generatorBuffer);

    return generatorBuffer.toString();
  }
}

class _TailorClassVisitor extends SimpleElementVisitor {
  _TailorClassVisitor({required this.themes});

  final SplayTreeSet<String> themes;
  final Map<String, Field> fields = {};
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      final propName = element.name;
      final coreType = coreIterableGenericType(element.type);
      final extendsThemeExtension = coreType.typeImplementations
              .firstWhereOrNull((t) => t.getDisplayString(withNullability: false).startsWith('ThemeExtension')) !=
          null;
      final hasTailorComponentAnnotation = coreType.element?.declaration?.metadata
              .map((annotation) => annotation.computeConstantValue()?.type?.getDisplayString(withNullability: false))
              .firstWhereOrNull((displayString) =>
                  displayString == (TailorComponent).toString() || displayString == (Tailor).toString()) !=
          null;

      final isThemeExtension = extendsThemeExtension || hasTailorComponentAnnotation;

      final themeExtensionFields = <String>[];

      if (isThemeExtension) {
        final fieldListingVisitor = _FieldListingVisitor();
        coreType.element!.visitChildren(fieldListingVisitor);
        themeExtensionFields.addAll(fieldListingVisitor.fieldNames);
      }

      if (element.metadata.isNotEmpty) {
        for (final annotation in element.metadata) {
          final encoderData = extractThemeEncoderData(
            annotation,
            annotation.computeConstantValue()!,
          );

          if (encoderData != null) {
            fieldLevelEncoders[propName] = encoderData;
          }
        }
      }

      fields[propName] = Field(
        name: propName,
        type: coreType,
        isAnotherTailorTheme: hasTailorComponentAnnotation,
        isThemeExtension: isThemeExtension,
        themeExtensionFields: themeExtensionFields,
      );
    }
  }
}

class _FieldListingVisitor extends SimpleElementVisitor<Object> {
  final List<String> fieldNames = [];

  @override
  void visitFieldElement(FieldElement element) {
    fieldNames.add(element.name);
  }
}
