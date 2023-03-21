import 'package:analyzer/dart/element/element.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:source_gen_test/annotations.dart';

extension ElementAnnotationExtension on ElementAnnotation {
  bool get isTailorAnnotation {
    return const TypeChecker.fromRuntime(Tailor)
        .isAssignableFromType(computeConstantValue()!.type!);
  }

  bool get isTailorThemeExtension {
    return TypeChecker.fromRuntime(themeExtension.runtimeType)
        .isAssignableFrom(computeConstantValue()!.type!.element!);
  }

  bool get isSourceGenAnnotation {
    final isShouldGenerate = TypeChecker.fromRuntime(ShouldGenerate)
        .isAssignableFromType(computeConstantValue()!.type!);
    final isShouldThrow = TypeChecker.fromRuntime(ShouldThrow)
        .isAssignableFromType(computeConstantValue()!.type!);
    return isShouldGenerate || isShouldThrow;
  }
}
