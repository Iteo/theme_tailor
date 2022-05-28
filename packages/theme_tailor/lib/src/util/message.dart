import 'package:analyzer/dart/element/element.dart';

class Message {
  static String unsupportedAnnotationTarget(Element element) {
    return 'Theme tailor cannot target ${element.runtimeType}. Please use the annotation on supported types';
  }
}
