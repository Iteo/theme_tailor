import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/util/import_finder.dart';

extension JsonSerializableLibraryElementExtension on LibraryElement {
  bool get hasJsonSerializableImport {
    return ImportFinder(
      lib: this,
      whereElement: isClass('JsonSerializable'),
      whereLibrary: isWithinLibrary('json_annotation'),
    )();
  }
}

extension JsonSerializableElementExtension on Element {
  bool get hasJsonSerializableAnnotation {
    return const TypeChecker.fromRuntime(JsonSerializable).hasAnnotationOf(
      this,
      throwOnUnresolved: false,
    );
  }
}
