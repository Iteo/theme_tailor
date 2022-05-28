import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../util/message.dart';

class ThemeTailorGenerator extends GeneratorForAnnotation<Tailor> {
  @override
  String generateForAnnotatedElement(Element element, ConstantReader annotation, BuildStep buildStep) {
    if (element is! ClassElement || element is Enum) {
      throw InvalidGenerationSourceError(
        Message.unsupportedAnnotationTarget(element),
        element: element,
      );
    }

    final strBuffer = StringBuffer()
      ..writeln(commented('$element'))
      ..writeln(commented(annotation.read('themes').listValue.map((e) => e.toStringValue()).toString()));

    return strBuffer.toString();
  }
}

String commented(String val) => '/// $val';
