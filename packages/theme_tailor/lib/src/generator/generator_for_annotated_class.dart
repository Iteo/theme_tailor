import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class GeneratorForAnnotatedClass<TLibraryData, TAnnotationData, TData,
    TAnnotation> extends GeneratorForAnnotation<TAnnotation> {
  @override
  String generateForAnnotatedElement(
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

    final buffer = StringBuffer()..writeAll(generateForData(data));
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

  Iterable<String> generateForData(TData data);
}
