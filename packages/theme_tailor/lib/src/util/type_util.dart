import 'package:analyzer/dart/element/type.dart';

class TypeUtil {
  static String dynamicType = 'dynamic';

  static String typeFromDartTypeCollection(Iterable<DartType?> collection) {
    if (collection.isEmpty) return dynamicType;

    final firstType = collection.elementAt(0);
    if (collection.any((e) => e != firstType)) return dynamicType;

    return firstType.toString();
  }
}
