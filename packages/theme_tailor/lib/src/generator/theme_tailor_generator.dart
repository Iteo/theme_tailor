import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<ThemeTailor> {
  @override
  generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    return '/// Test';
  }
}
