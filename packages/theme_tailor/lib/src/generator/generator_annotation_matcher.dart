import 'dart:async';
import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class GeneratorToBuffer<TAnnotation>
    extends GeneratorForAnnotation<TAnnotation> {
  const GeneratorToBuffer();

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  );

  void generateToBuffer(
    StringBuffer buffer,
    Element element,
    ConstantReader annotation,
  );
}

abstract class GeneratorAnnotationMatcher<TAnnotation>
    extends GeneratorForAnnotation<TAnnotation> {
  const GeneratorAnnotationMatcher();

  @override
  // ignore: avoid_renaming_method_parameters
  Future<String> generate(LibraryReader oldLib, BuildStep buildStep) async {
    final assetId = await buildStep.resolver.assetIdForElement(oldLib.element);
    if (await buildStep.resolver.isLibrary(assetId).then((value) => !value)) {
      return '';
    }

    final library = await buildStep.resolver.libraryFor(assetId);

    final buffer = StringBuffer();
    final tailorAnnotatedElements =
        library.topLevelElements.where(typeChecker.hasAnnotationOf);

    for (final element in tailorAnnotatedElements) {
      getGeneratorFrom(element).generateToBuffer(
        buffer,
        element,
        ConstantReader(typeChecker.firstAnnotationOf(element)),
      );
    }

    return buffer.toString();
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    return '';
  }

  GeneratorToBuffer<TAnnotation> getGeneratorFrom(Element element);
}
