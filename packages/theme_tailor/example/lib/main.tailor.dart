// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main.dart';

// **************************************************************************
// ThemeTailorGenerator
// **************************************************************************

class CustomThemeExtensionLightDark2 extends ThemeExtension<CustomThemeExtensionLightDark2> {
  const CustomThemeExtensionLightDark2({
    required this.h3,
    required this.luckyNumber,
  });

  final TextData h3;
  final int luckyNumber;

  @override
  ThemeExtension<CustomThemeExtensionLightDark2> copyWith({
    TextData? h3,
    int? luckyNumber,
  }) {
    return CustomThemeExtensionLightDark2(
      h3: h3 ?? this.h3,
      luckyNumber: luckyNumber ?? this.luckyNumber,
    );
  }

  @override
  ThemeExtension<CustomThemeExtensionLightDark2> lerp(other, t) {
    if (other is! CustomThemeExtensionLightDark2) return this;
    return CustomThemeExtensionLightDark2(
      h3: simpleLerp(h3, other.h3, t),
      luckyNumber: simpleLerp(luckyNumber, other.luckyNumber, t),
    );
  }

  T simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
}
