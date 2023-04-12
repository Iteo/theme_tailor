import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/generator_for_annotated_class.dart';
import 'package:theme_tailor/src/model/library_data.dart';
import 'package:theme_tailor/src/model/tailor_annotation_data.dart';
import 'package:theme_tailor/src/model/tailor_mixin_classes.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/template/tailor_mixin_template.dart';
import 'package:theme_tailor/src/util/extension/contant_reader_extension.dart';
import 'package:theme_tailor/src/util/extension/element_extension.dart';
import 'package:theme_tailor/src/util/theme_encoder_helper.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

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
      ..template(TailorMixinTemplate.fromConfig(data));

    yield buffer.toString();
  }

  @override
  TailorMixinAnnotationData parseAnnotation(ConstantReader annotation) {
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
    final className = element.displayName;
    final fields = element.fields
        .map((e) => TailorMixinField(
            name: e.displayName,
            type: e.type.getDisplayString(withNullability: true)))
        .toList(growable: false);

    return TailorMixinConfig(
      className: className,
      fields: fields,
    );
  }

  @override
  TailorMixinImports parseLibraryData(
    LibraryElement library,
    ClassElement element,
  ) {
    final isDiagnosticable = element.hasMixinNamed('DiagnosticableTreeMixin');
    return TailorMixinImports(hasFlutterDiagnosticable: isDiagnosticable);
  }
}
