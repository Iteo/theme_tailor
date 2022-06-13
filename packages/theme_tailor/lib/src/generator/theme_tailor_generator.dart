import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
import 'package:collection/collection.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_extension_config.dart';
import 'package:theme_tailor/src/template/theme_extension_class_templates.dart';
import 'package:theme_tailor/src/type_helper/iterable_helper.dart';
import 'package:theme_tailor/src/type_helper/theme_encoder_helper.dart';
import 'package:theme_tailor/src/util/util.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    if (element is! ClassElement || element is Enum) {
      if (element is Enum) {}
      throw InvalidGenerationSourceError(
        'Tailor can only annotate classes',
        element: element,
        todo: 'Move @Tailor annotation above `class`',
      );
    }

    const stringUtil = StringUtil();

    final className = element.name;
    final themes = SplayTreeSet<String>.from(
        annotation.read('themes').listValue.map((e) => e.toStringValue()));
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
      final encoderData = extractThemeEncoderData(
          annotation, annotation.computeConstantValue()!);
      if (encoderData != null) {
        classLevelEncoders[encoderData.type] = encoderData;
      }
    }

    final tailorClassVisitor = _TailorClassVisitor(themes: themes);
    element.visitChildren(tailorClassVisitor);

    final config = ThemeExtensionClassConfig(
      fields: tailorClassVisitor.fields,
      returnType: stringUtil.formatClassName(className),
      baseClassName: className,
      themes: themes,
      encoderDataManager: ThemeEncoderDataManager(
        classLevelEncoders,
        tailorClassVisitor.fieldLevelEncoders,
      ),
    );

    return ThemeExtensionClassTemplate(config).toString();
  }
}

class _TailorClassVisitor extends SimpleElementVisitor {
  _TailorClassVisitor({required this.themes});

  final SplayTreeSet<String> themes;
  final SplayTreeMap<String, Field> fields = SplayTreeMap();
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      final propName = element.name;
      final coreType = coreIterableGenericType(element.type);
      final typeDeclarationMetadata = coreType.element?.declaration?.metadata;

      if (typeDeclarationMetadata != null) {
        for (final typeDeclarationAnnotation in typeDeclarationMetadata) {
          final typeName =
              typeDeclarationAnnotation.computeConstantValue()?.type?.getDisplayString(withNullability: false);

          if (typeName != null && typeName == (Tailor).toString()) {
            if (!_validateThemesAnnotation(typeDeclarationAnnotation)) {
              throw InvalidGenerationSourceError(
                'Tailor themes can only be used on extensions with the same themes as enclosing class.\n'
                'Make sure that ${coreType.getDisplayString(withNullability: false)} has following themes ${themes.toList()}.',
                element: element.declaration,
              );
            }

            fields[propName] = Field(
              name: propName,
              type: coreType,
              isAnotherTailorTheme: true,
            );

            return;
          }
        }
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
        isAnotherTailorTheme: false,
      );
    }
  }

  bool _validateThemesAnnotation(ElementAnnotation typeDeclarationAnnotation) {
    final typeDeclarationThemes = SplayTreeSet<String>.from(
      typeDeclarationAnnotation
              .computeConstantValue()
              ?.getField('themes')
              ?.toListValue()
              ?.map((e) => e.toStringValue())
              .where((e) => e != null) ??
          const Iterable.empty(),
    );

    return const ListEquality().equals(themes.toList(), typeDeclarationThemes.toList());
  }
}
