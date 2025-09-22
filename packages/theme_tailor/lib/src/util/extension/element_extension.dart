import 'package:analyzer/dart/element/element2.dart';
import 'package:collection/collection.dart';
import 'package:json_annotation/json_annotation.dart' show JsonSerializable;
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/constructor_data.dart';
import 'package:theme_tailor/src/model/referenced_packages.dart';
import 'package:theme_tailor/src/util/extension/parameter_element_extension.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

extension ElementExtension on Element2 {
  bool get hasJsonSerializableAnnotation {
    const checker = TypeChecker.typeNamed(JsonSerializable, inPackage: ReferencedPackages.jsonSerializable);
    return checker.hasAnnotationOf(this, throwOnUnresolved: false);
  }

  bool isFromPackage(String package) {
    return library2?.firstFragment.source.fullName.startsWith('/$package/') ?? false;
  }

  bool get hasTailorMixinAnnotation {
    const checker = TypeChecker.typeNamed(TailorMixin, inPackage: ReferencedPackages.jsonSerializable);
    return checker.hasAnnotationOf(this, throwOnUnresolved: false);
  }

  bool get hasThemeExtensionAnnotation {
    const checker = TypeChecker.typeNamed(TailorThemeExtension, inPackage: ReferencedPackages.themeTailorAnnotation);
    return checker.hasAnnotationOf(this, throwOnUnresolved: false);
  }
}

extension ClassElementExtensions on ClassElement2 {
  bool hasMixinNamed(String mixin) {
    return mixins.map((e) => e.element3.name3).contains(mixin);
  }

  ConstructorElement2? get _defaultCtor {
    return constructors2.firstWhereOrNull((ctor) => ctor.name3 == 'new');
  }

  ConstructorData? constructorData() {
    final ctor = _defaultCtor;
    final parameters = ctor?.formalParameters;

    if (parameters == null || parameters.isEmpty) return null;

    return ConstructorData(
      constructorName: ctor!.displayName,
      parameterNameToType: Map.fromEntries(parameters.map((e) => MapEntry(e.name3!, e.parameterType))),
    );
  }
}
