// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main.dart';

// **************************************************************************
// ThemeTailorGenerator
// **************************************************************************

// DEBUG:
// Class name: OK
// Themes: dark light
// Properties: (MapEntry(appBar: Color), MapEntry(background: Color), MapEntry(h1: TextStyle), MapEntry(h2: TextStyle), MapEntry(surface: Color))
class OK extends ThemeExtension<OK> {
  OK({
    required this.appBar,
    required this.background,
    required this.h1,
    required this.h2,
    required this.surface,
  });

  final Color appBar;
  final Color background;
  final TextStyle h1;
  final TextStyle h2;
  final Color surface;

  static final OK dark = OK(
    appBar: $_OK.appBar[0],
    background: $_OK.background[0],
    h1: $_OK.h1[0],
    h2: $_OK.h2[0],
    surface: $_OK.surface[0],
  );

  static final OK light = OK(
    appBar: $_OK.appBar[1],
    background: $_OK.background[1],
    h1: $_OK.h1[1],
    h2: $_OK.h2[1],
    surface: $_OK.surface[1],
  );

  @override
  ThemeExtension<OK> copyWith({
    Color? appBar,
    Color? background,
    TextStyle? h1,
    TextStyle? h2,
    Color? surface,
  }) {
    return OK(
      appBar: appBar ?? this.appBar,
      background: background ?? this.background,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      surface: surface ?? this.surface,
    );
  }

  @override
  ThemeExtension<OK> lerp(other, t) {
    if (other is! OK) return this;
    return OK(
      appBar: _simpleLerp(appBar, other.appBar, t),
      background: _simpleLerp(background, other.background, t),
      h1: _simpleLerp(h1, other.h1, t),
      h2: _simpleLerp(h2, other.h2, t),
      surface: _simpleLerp(surface, other.surface, t),
    );
  }

  T _simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
}
