import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/generator_for_annotated_class.dart';
import 'package:theme_tailor/src/model/library_data.dart';
import 'package:theme_tailor/src/model/tailor_annotation_data.dart';
import 'package:theme_tailor/src/model/tailor_mixin_classes.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';
import 'package:theme_tailor/src/template/tailor_mixin_template.dart';
import 'package:theme_tailor/src/util/extension/contant_reader_extension.dart';
import 'package:theme_tailor/src/util/extension/dart_type_extension.dart';
import 'package:theme_tailor/src/util/extension/element_extension.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor/src/util/extension/scope_extension.dart';

class TailorMixinGenerator extends GeneratorForAnnotatedClass<
    TailorMixinImports, TailorMixinAnnotationData, TailorMixinConfig, Tailor> {
  const TailorMixinGenerator(this.buildYamlConfig);

  final Tailor buildYamlConfig;

  @override
  ClassElement ensureClassElement(Element element) {
    if (element is ClassElement && element is! Enum) return element;

    throw InvalidGenerationSourceError(
      '@TailorMixin can only annotate classes',
      element: element,
      todo: 'Move @TailorMixin annotation above `class`',
    );
  }

  @override
  Iterable<String> generateForData(TailorMixinConfig data) sync* {
    final buffer = StringBuffer()
      ..template(TailorMixinTemplate(
        data.className,
        data.fields,
        data.encoderDataManager,
        data.hasDiagnosticableMixin,
      ))
      ..template(TailorMixinExtensionTemplate(
        data.className,
        data.extensionData,
        data.fields,
      ));

    yield buffer.toString();
  }

  @override
  TailorMixinAnnotationData parseAnnotation(ConstantReader annotation) {
    print(annotation.toString());

    final themeGetter = annotation.getFieldOrElse(
      'themeGetter',
      decode: (o) =>
          ThemeGetter.values.byName(o.revive().accessor.split('.').last),
      orElse: () =>
          buildYamlConfig.themeGetter ?? ThemeGetter.onBuildContextProps,
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
    );
  }

  @override
  TailorMixinConfig parseData(
    TailorMixinImports libraryData,
    TailorMixinAnnotationData annotationData,
    ClassElement element,
  ) {
    final nonStaticFields = element.fields.where((e) => !e.isStatic).toList();

    /// Encoders processing
    final encodersTypeNameToEncoder = annotationData.encoders;
    for (final annotation in element.metadata) {
      extractThemeEncoderData(
        annotation,
        annotation.computeConstantValue()!,
      )?.let((encoder) => encodersTypeNameToEncoder[encoder.type] = encoder);
    }

    final encodersFieldNameToEncoder = <String, ThemeEncoderData>{};
    for (final field in nonStaticFields) {
      for (final annotation in field.metadata) {
        extractThemeEncoderData(
          annotation,
          annotation.computeConstantValue()!,
        )?.let((encoder) => encodersFieldNameToEncoder[field.name] = encoder);
      }
    }

    final encoderManager = ThemeEncoderManager(
      encodersTypeNameToEncoder,
      encodersFieldNameToEncoder,
    );

    /// Fields
    final fields = nonStaticFields.map((e) {
      final isThemeExtension =
          e.type.isThemeExtensionType || e.hasThemeExtensionAnnotation;

      return TailorMixinField(
        isThemeExtension: isThemeExtension,
        name: e.displayName,
        type: e.type.getDisplayString(withNullability: true),
        documentationComment: e.documentationComment,
      );
    }).toList(growable: false);

    return TailorMixinConfig(
      className: element.displayName,
      fields: fields,
      encoderDataManager: encoderManager,
      hasDiagnosticableMixin: libraryData.hasDiagnosticableMixin,
      extensionData: annotationData.themeGetter.extensionData,
    );
  }

  @override
  TailorMixinImports parseLibraryData(
    LibraryElement library,
    ClassElement element,
  ) {
    final isDiagnosticable = element.hasMixinNamed('DiagnosticableTreeMixin');
    return TailorMixinImports(hasDiagnosticableMixin: isDiagnosticable);
  }
}
