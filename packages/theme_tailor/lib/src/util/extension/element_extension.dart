import 'package:analyzer/dart/element/element.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

extension ElementExtension on Element {
  bool get hasJsonSerializableAnnotation {
    const checker = TypeChecker.fromRuntime(JsonSerializable);
    return checker.hasAnnotationOf(this, throwOnUnresolved: false);
  }

  bool isFromPackage(String package) {
    return library?.librarySource.fullName.startsWith('/$package/') ?? false;
  }

  bool get hasTailorMixinAnnotation {
    const checker = TypeChecker.fromRuntime(TailorMixin);
    return checker.hasAnnotationOf(this, throwOnUnresolved: false);
  }
}

extension ClassElementExtensions on ClassElement {
  bool hasMixinNamed(String mixin) {
    return mixins.map((e) => e.element.name).contains(mixin);
  }
}
