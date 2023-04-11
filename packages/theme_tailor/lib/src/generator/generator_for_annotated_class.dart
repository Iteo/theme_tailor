import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator_annotation_matcher.dart';

abstract class GeneratorForAnnotatedClass<TLibraryData, TAnnotationData, TData,
    TAnnotation> extends StringIterableGenerator<TAnnotation> {
  @override
  Iterable<String> generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final classElement = ensureClassElement(element);
    final data = parseData(
      parseLibraryData(classElement.library, classElement),
      parseAnnotation(annotation),
      classElement,
    );

    return generateForData(data);
  }

  TLibraryData parseLibraryData(LibraryElement library, ClassElement element);

  TAnnotationData parseAnnotation(ConstantReader annotation);

  ClassElement ensureClassElement(Element element);

  TData parseData(
    TLibraryData libraryData,
    TAnnotationData annotationData,
    ClassElement element,
  );

  Iterable<String> generateForData(TData data);
}
