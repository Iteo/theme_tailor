import 'package:analyzer/dart/element/element2.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/generator_annotation_matcher.dart';

abstract class GeneratorForAnnotatedClass<TLibraryData, TAnnotationData, TData, TAnnotation>
    extends GeneratorToBuffer<TAnnotation> {
  const GeneratorForAnnotatedClass();

  @override
  void generateToBuffer(
    StringBuffer buffer,
    Element2 element,
    ConstantReader annotation,
  ) {
    final classElement = ensureClassElement(element);
    final data = parseData(
      parseLibraryData(classElement.library2, classElement),
      parseAnnotation(annotation),
      classElement,
    );

    generateForData(buffer, data);
  }

  @override
  String generateForAnnotatedElement(
    Element2 element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final buffer = StringBuffer();
    generateToBuffer(buffer, element, annotation);
    return buffer.toString();
  }

  TLibraryData parseLibraryData(LibraryElement2 library, ClassElement2 element);

  TAnnotationData parseAnnotation(ConstantReader annotation);

  ClassElement2 ensureClassElement(Element2 element);

  TData parseData(
    TLibraryData libraryData,
    TAnnotationData annotationData,
    ClassElement2 element,
  );

  void generateForData(StringBuffer buffer, TData data);
}
