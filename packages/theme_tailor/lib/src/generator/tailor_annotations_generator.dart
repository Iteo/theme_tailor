// ignore_for_file: deprecated_member_use

import 'package:analyzer/dart/element/element.dart';
import 'package:theme_tailor/src/generator/generator_annotation_matcher.dart';
import 'package:theme_tailor/src/generator/tailor_mixin_generator.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class TailorAnnotationsGenerator extends GeneratorAnnotationMatcher<TailorMixin> {
  const TailorAnnotationsGenerator(this.buildYamlConfig);

  final TailorMixin buildYamlConfig;

  @override
  GeneratorToBuffer<TailorMixin> getGeneratorFrom(Element element) => TailorMixinGenerator(buildYamlConfig);
}
