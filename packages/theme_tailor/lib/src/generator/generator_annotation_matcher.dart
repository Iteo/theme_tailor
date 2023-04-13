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
  // ignore: avoid_renaming_method_parameters
  Future<String> generate(LibraryReader oldLib, BuildStep buildStep) async {
    final assetId = await buildStep.resolver.assetIdForElement(oldLib.element);
    if (await buildStep.resolver.isLibrary(assetId).then((value) => !value)) {
      return '';
    }

    final library = await buildStep.resolver.libraryFor(assetId);

    final values = StringBuffer();

    library.topLevelElements.where(typeChecker.hasAnnotationOf).forEach(
      (element) {
        final annotation = ConstantReader(
            TypeChecker.fromRuntime(TAnnotation).firstAnnotationOf(element));

        matchGenerator(element)
            .generateForAnnotatedElement(element, annotation, buildStep)
            .forEach(values.writeln);
      },
    );

    return values.toString();
  }

  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return Iterable.empty();
  }

  StringIterableGenerator<TAnnotation> matchGenerator(Element element);
}
