import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/model/referenced_packages.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

extension ElementAnnotationExtension on Element2 {
  bool get isTailorAnnotation {
    return const TypeChecker.typeNamed(
      TailorMixin,
      inPackage: ReferencedPackages.themeTailorAnnotation,
    ).hasAnnotationOf(this, throwOnUnresolved: false);
  }

  bool get isTailorThemeExtension {
    return const TypeChecker.typeNamed(
      TailorThemeExtension,
      inPackage: ReferencedPackages.themeTailorAnnotation,
    ).isAssignableFrom(this);
  }
}
