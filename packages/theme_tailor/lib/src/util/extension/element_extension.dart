import 'package:analyzer/dart/element/element.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/constructor_parameters.dart';
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

  Set<String> fieldNames() {
    return fields.where((e) => !e.isStatic).map((e) => e.name).toSet();
  }

  ConstructorElement? preferedConstructor() {
    return constructors.firstWhereOrNull((cstr) => cstr.name.isEmpty);
  }

  ConstructorElement? firstConstructorWithFieldNames() {
    return constructors.firstWhereOrNull(
      (cstr) {
        return cstr.parameters
            .map((e) => e.name)
            .toSet()
            .containsAll(fieldNames());
      },
    );
  }

  ConstructorData? constructorData() {
    final ctor = (preferedConstructor() ?? firstConstructorWithFieldNames());

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

extension on ParameterElement {
  CtorParamType get parameterType {
    return isNamed
        ? CtorParamType.named
        : isRequired
            ? CtorParamType.required
            : CtorParamType.optional;
  }
}
