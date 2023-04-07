import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:source_gen/source_gen.dart';

extension ElementExtension on Element {
  bool get hasJsonSerializableAnnotation {
    return const TypeChecker.fromRuntime(JsonSerializable).hasAnnotationOf(
      this,
      throwOnUnresolved: false,
    );
  }

  bool isFromPackage(String package) {
    return library?.librarySource.fullName.startsWith('/$package/') ?? false;
  }
}
