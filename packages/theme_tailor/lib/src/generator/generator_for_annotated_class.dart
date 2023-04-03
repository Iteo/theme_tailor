import 'package:analyzer/dart/element/element.dart';
import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

abstract class GeneratorForAnnotatedClass<TLibraryData, TAnnotationData,
    TAnnotation> extends GeneratorForAnnotation<TAnnotation> {
  @override
  dynamic generateForAnnotatedElement(
    Element element,
    ConstantReader annotation,
    BuildStep buildStep,
  ) {
    final classElement = ensureClassElement(element);

    return generateForAnnotation(
      parseLibraryData(classElement.library),
      parseAnnotation(annotation),
      classElement,
    );
  }

  TLibraryData parseLibraryData(LibraryElement lib);

  TAnnotationData parseAnnotation(ConstantReader annotation);

  ClassElement ensureClassElement(Element element);

  dynamic generateForAnnotation(
    TLibraryData lib,
    TAnnotationData data,
    ClassElement element,
  );
}
