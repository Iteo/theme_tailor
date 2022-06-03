// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'theme_wih_enums.dart';

// **************************************************************************
// ThemeTailorGenerator
// **************************************************************************

// DEBUG:
// Class name: ThemeWithEnums
// Themes: dark light superDark superLight
// Properties: (MapEntry(enums1: SuperThemeEnum), MapEntry(enums2: SuperThemeEnum))
class ThemeWithEnums extends ThemeExtension<ThemeWithEnums> {
  ThemeWithEnums({
    required this.enums1,
    required this.enums2,
  });

  final SuperThemeEnum enums1;
  final SuperThemeEnum enums2;

  static final ThemeWithEnums dark = ThemeWithEnums(
    enums1: $_ThemeWithEnums.enums1[0],
    enums2: $_ThemeWithEnums.enums2[0],
  );

  static final ThemeWithEnums light = ThemeWithEnums(
    enums1: $_ThemeWithEnums.enums1[1],
    enums2: $_ThemeWithEnums.enums2[1],
  );

  static final ThemeWithEnums superDark = ThemeWithEnums(
    enums1: $_ThemeWithEnums.enums1[2],
    enums2: $_ThemeWithEnums.enums2[2],
  );

  static final ThemeWithEnums superLight = ThemeWithEnums(
    enums1: $_ThemeWithEnums.enums1[3],
    enums2: $_ThemeWithEnums.enums2[3],
  );

  @override
  ThemeExtension<ThemeWithEnums> copyWith({
    SuperThemeEnum? enums1,
    SuperThemeEnum? enums2,
  }) {
    return ThemeWithEnums(
      enums1: enums1 ?? this.enums1,
      enums2: enums2 ?? this.enums2,
    );
  }

  @override
  ThemeExtension<ThemeWithEnums> lerp(other, t) {
    if (other is! ThemeWithEnums) return this;
    return ThemeWithEnums(
      enums1: _simpleLerp(enums1, other.enums1, t),
      enums2: _simpleLerp(enums2, other.enums2, t),
    );
  }

  T _simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
}
