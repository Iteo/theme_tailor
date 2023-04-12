import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/generator_annotation_matcher.dart';
import 'package:theme_tailor/src/generator/theme_tailor_generator.dart';
import 'package:theme_tailor/src/util/extension/element_extension.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class TailorAnnotationsGenerator extends GeneratorAnnotationMatcher<Tailor> {
  const TailorAnnotationsGenerator(this.buildYamlConfig);

  final Tailor buildYamlConfig;

  @override
  StringIterableGenerator<Tailor> matchGenerator(Element element) {
    if (element.hasTailorMixinAnnotation) {
      return TailorMixinGenerator();
    }
    return TailorGenerator(buildYamlConfig);
  }
}

class TailorMixinGenerator extends StringIterableGenerator<Tailor> {
  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) sync* {
    yield '''
    /// This is a tailor mixin :D!
    /// This is not ready yet
    ''';
  }
}
