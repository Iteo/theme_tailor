import 'package:analyzer/dart/element/element2.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

extension ElementAnnotationExtension on ElementAnnotation {
  bool get isTailorAnnotation {
    return const TypeChecker.fromRuntime(TailorMixin).isAssignableFromType(computeConstantValue()!.type!);
  }

  bool get isTailorThemeExtension {
    return TypeChecker.fromRuntime(themeExtension.runtimeType)
        .isAssignableFrom(computeConstantValue()!.type!.element3!);
  }
}
