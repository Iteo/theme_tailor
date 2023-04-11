import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/generator_annotation_matcher.dart';
import 'package:theme_tailor/src/generator/theme_tailor_generator.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class TailorAnnotationsGenerator extends GeneratorAnnotationMatcher<Tailor> {
  const TailorAnnotationsGenerator(this.buildYamlConfig);

  final Tailor buildYamlConfig;

  TypeChecker get tailorChecker => TypeChecker.fromRuntime(Tailor);

  @override
  StringIterableGenerator<Tailor> matchGeneratorForAnnotation(
    AnnotatedElement annotatedElement,
  ) {
    if (tailorChecker.isAssignableFrom(annotatedElement.element)) {
      return TailorGenerator(buildYamlConfig);
    }
    return TailorGenerator(buildYamlConfig);
  }
}
