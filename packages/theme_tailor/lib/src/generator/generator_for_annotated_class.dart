import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'generator_annotation_matcher.dart';

abstract class GeneratorForAnnotatedClass<TLibraryData, TAnnotationData, TData,
    TAnnotation> extends GeneratorToBuffer<TAnnotation> {
  const GeneratorForAnnotatedClass();

  @override
  void generateToBuffer(
    StringBuffer buffer,
    Element element,
    ConstantReader annotation,
  ) {
    final classElement = ensureClassElement(element);
    final data = parseData(
      parseLibraryData(classElement.library, classElement),
      parseAnnotation(annotation),
      classElement,
    );

    generateForData(buffer, data);
  }

  @override
  String generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();
    generateToBuffer(buffer, element, annotation);
    return buffer.toString();
  }

  TLibraryData parseLibraryData(LibraryElement library, ClassElement element);

  TAnnotationData parseAnnotation(ConstantReader annotation);

  ClassElement ensureClassElement(Element element);

  TData parseData(
    TLibraryData libraryData,
    TAnnotationData annotationData,
    ClassElement element,
  );

  void generateForData(StringBuffer buffer, TData data);
}
