import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/constructor_data.dart';
import 'package:theme_tailor/src/util/extension/parameter_element_extension.dart';
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

  bool get hasThemeExtensionAnnotation {
    final checker = TypeChecker.fromRuntime(themeExtension.runtimeType);
    return checker.hasAnnotationOf(this, throwOnUnresolved: false);
  }
}

extension ClassElementExtensions on ClassElement {
  bool hasMixinNamed(String mixin) {
    return mixins.map((e) => e.element.name).contains(mixin);
  }

  ConstructorElement? get _defaultCtor {
    return constructors.firstWhereOrNull((ctor) => ctor.name.isEmpty);
  }

  ConstructorData? constructorData() {
    final ctor = _defaultCtor;
    final parameters = ctor?.parameters;

    if (parameters == null || parameters.isEmpty) return null;

    return ConstructorData(
      constructorName: ctor!.displayName,
      parameterNameToType: Map.fromEntries(
        parameters.map((e) => MapEntry(e.name, e.parameterType)),
      ),
    );
  }
}
