import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class StringIterableGenerator<TAnnotation>
    extends GeneratorForAnnotation<TAnnotation> {
  const StringIterableGenerator();

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  );
}

abstract class GeneratorAnnotationMatcher<TAnnotation>
    extends StringIterableGenerator<TAnnotation> {
  const GeneratorAnnotationMatcher();

  @override
  FutureOr<String> generate(LibraryReader library, BuildStep buildStep) async {
    final values = StringBuffer();

    library.annotatedWith(typeChecker).forEach(
      (e) {
        matchGeneratorForAnnotation(e)
            .generateForAnnotatedElement(e.element, e.annotation, buildStep)
            .forEach(values.writeln);
      },
    );

    return values.toString();
  }

  @override
  Iterable<String> generateForAnnotatedElement(
      Element element, ConstantReader annotation, BuildStep buildStep) {
    return Iterable.empty();
  }

  StringIterableGenerator<TAnnotation> matchGeneratorForAnnotation(
    AnnotatedElement annotatedElement,
  );
}
