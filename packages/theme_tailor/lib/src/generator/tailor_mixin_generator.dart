import 'package:analyzer/dart/element/element2.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/generator_for_annotated_class.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/library_data.dart';
import 'package:theme_tailor/src/model/tailor_mixin_annotation_data.dart';
import 'package:theme_tailor/src/model/tailor_mixin_classes.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';
import 'package:theme_tailor/src/template/context_extension_template.dart';
import 'package:theme_tailor/src/template/tailor_mixin_template.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/util/extension/contant_reader_extension.dart';
import 'package:theme_tailor/src/util/extension/dart_type_extension.dart';
import 'package:theme_tailor/src/util/extension/element_extension.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class TailorMixinGenerator
    extends GeneratorForAnnotatedClass<ImportsData, TailorMixinAnnotationData, TailorMixinConfig, TailorMixin> {
  const TailorMixinGenerator(this.buildYamlConfig);

  final TailorMixin buildYamlConfig;

  @override
  ClassElement2 ensureClassElement(Element2 element) {
    if (element is ClassElement2 && element is! Enum) return element;

    throw InvalidGenerationSourceError(
      '@TailorMixin can only annotate classes',
      element: element,
      todo: 'Move @TailorMixin annotation above `class`',
    );
  }

  @override
  void generateForData(StringBuffer buffer, TailorMixinConfig data) => buffer
    ..template(
      TailorMixinTemplate(
        data.className,
        data.fields,
        data.encoderDataManager,
        data.constructorData,
        hasDiagnosticableMixin: data.hasDiagnosticableMixin,
      ),
    )
    ..template(
      ContextExtensionTemplate(
        data.className,
        data.extensionData,
        data.fields,
        data.themeClassName,
        data.themeDataClassName,
      ),
    );

  @override
  TailorMixinAnnotationData parseAnnotation(ConstantReader annotation) {
    final themeGetter = annotation.getFieldOrElse(
      'themeGetter',
      decode: (o) => ThemeGetter.values.byName(o.revive().accessor.split('.').last),
      orElse: () => buildYamlConfig.themeGetter ?? ThemeGetter.onBuildContextProps,
    );

    final themeClassName = annotation.getFieldOrElse(
      'themeClassName',
      decode: (o) => o.stringValue,
      orElse: () => buildYamlConfig.themeClassName ?? 'Theme',
    );

    final themeDataClassName = annotation.getFieldOrElse(
      'themeDataClassName',
      decode: (o) => o.stringValue,
      orElse: () => buildYamlConfig.themeDataClassName,
    );

    final encoders = annotation.getFieldOrElse<Map<String, ThemeEncoderData>>(
      'encoders',
      decode: (o) => Map.fromEntries(
        o.listValue
            .map((dartObject) => extractThemeEncoderData(null, dartObject))
            .whereType<ThemeEncoderData>()
            .map((encoderData) => MapEntry(encoderData.type, encoderData)),
      ),
      orElse: () => {},
    );

    return TailorMixinAnnotationData(
      themeGetter: themeGetter,
      encoders: encoders,
      themeClassName: themeClassName,
      themeDataClassName: themeDataClassName,
    );
  }

  @override
  TailorMixinConfig parseData(
    ImportsData libraryData,
    TailorMixinAnnotationData annotationData,
    ClassElement2 element,
  ) {
    final nonStaticFields = element.fields2.where((e) => !e.isStatic).toList();

    /// Encoders processing
    final encodersTypeNameToEncoder = annotationData.encoders;
    for (final annotation in element.metadata2.annotations) {
      final annotationConstValue = annotation.computeConstantValue();
      if (annotationConstValue == null) continue;

      final encoder = extractThemeEncoderData(
        annotation,
        annotationConstValue,
      );
      if (encoder == null) continue;

      encodersTypeNameToEncoder[encoder.type] = encoder;
    }

    final encodersFieldNameToEncoder = <String, ThemeEncoderData>{};
    for (final field in nonStaticFields) {
      for (final annotation in field.metadata2.annotations) {
        final fieldName = field.name3;
        if (fieldName == null) continue;

        final encoder = extractThemeEncoderData(
          annotation,
          annotation.computeConstantValue()!,
        );
        if (encoder == null) continue;

        encodersFieldNameToEncoder[fieldName] = encoder;
      }
    }

    final encoderManager = ThemeEncoderManager(
      encodersTypeNameToEncoder,
      encodersFieldNameToEncoder,
    );

    /// Fields
    final fields = nonStaticFields.map((e) {
      final isThemeExtension = e.type.isThemeExtensionType || e.hasThemeExtensionAnnotation;

      return Field(
        isThemeExtension: isThemeExtension,
        name: e.displayName,
        type: e.type.getDisplayString(),
        documentation: e.documentationComment,
      );
    }).toList(growable: false);

    return TailorMixinConfig(
      className: element.displayName,
      fields: fields,
      encoderDataManager: encoderManager,
      hasDiagnosticableMixin: libraryData.hasDiagnosticableMixin,
      extensionData: annotationData.themeGetter.extensionData,
      constructorData: element.constructorData(),
      themeClassName: annotationData.themeClassName,
      themeDataClassName: annotationData.themeDataClassName,
    );
  }

  @override
  ImportsData parseLibraryData(
    LibraryElement2 library,
    ClassElement2 element,
  ) {
    final isDiagnosticable = element.hasMixinNamed('DiagnosticableTreeMixin');
    return ImportsData(hasDiagnosticableMixin: isDiagnosticable);
  }
}
