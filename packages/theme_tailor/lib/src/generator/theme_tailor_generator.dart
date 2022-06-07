import 'dart:collection';

import 'package:analyzer/dart/element/element.dart';
import 'package:analyzer/dart/element/visitor.dart';
import 'package:build/build.dart';
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
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError('Tailor can only annotate classes', element: element);
    }

    const stringUtil = StringUtil();

    final className = element.name;
    final themes = SplayTreeSet<String>.from(annotation.read('themes').listValue.map((e) => e.toStringValue()));
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

    final tailorClassVisitor = _TailorClassVisitor();
    element.visitChildren(tailorClassVisitor);

    final config = ThemeExtensionClassConfig(
      fields: tailorClassVisitor.fields,
      returnType: stringUtil.formatClassName(className),
      baseClassName: className,
      themes: themes,
      encoderDataManager: ThemeEncoderDataManager(classLevelEncoders, tailorClassVisitor.fieldLevelEncoders),
    );

    final debug = '''
    // DEBUG:
    // Class name: ${config.returnType}
    // Themes: ${config.themes.join(' ')}
    // Properties: ${config.fields.entries}
    // Encoders: ${config.encoderDataManager}
    ''';

    final outputBuffer = StringBuffer(debug)..write(ThemeExtensionClassTemplate(config));

    return outputBuffer.toString();
  }
}

class _TailorClassVisitor extends SimpleElementVisitor {
  final SplayTreeMap<String, Field> fields = SplayTreeMap();
  final Map<String, ThemeEncoderData> fieldLevelEncoders = {};

  @override
  void visitFieldElement(FieldElement element) {
    if (element.isStatic && element.type.isDartCoreList) {
      final propName = element.name;

      if (element.metadata.isNotEmpty) {
        for (final annotation in element.metadata) {
          final encoderData = extractThemeEncoderData(annotation, annotation.computeConstantValue()!);
          if (encoderData != null) {
            fieldLevelEncoders[propName] = encoderData;
          }
        }
      }

      fields[propName] = Field(propName, coreIterableGenericType(element.type));
    }
  }
}
