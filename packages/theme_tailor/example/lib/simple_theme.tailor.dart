// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'simple_theme.dart';

// **************************************************************************
// ThemeTailorGenerator
// **************************************************************************

// DEBUG:
// Class name: SimpleTheme
// Themes: dark light
// Properties: (MapEntry(appBar: Color), MapEntry(background: Color), MapEntry(h1: TextStyle), MapEntry(h2: TextStyle), MapEntry(surface: Color))
class SimpleTheme extends ThemeExtension<SimpleTheme> {
  SimpleTheme({
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

  static final SimpleTheme dark = SimpleTheme(
    appBar: $_SimpleTheme.appBar[0],
    background: $_SimpleTheme.background[0],
    h1: $_SimpleTheme.h1[0],
    h2: $_SimpleTheme.h2[0],
    surface: $_SimpleTheme.surface[0],
  );

  static final SimpleTheme light = SimpleTheme(
    appBar: $_SimpleTheme.appBar[1],
    background: $_SimpleTheme.background[1],
    h1: $_SimpleTheme.h1[1],
    h2: $_SimpleTheme.h2[1],
    surface: $_SimpleTheme.surface[1],
  );

  @override
  ThemeExtension<SimpleTheme> copyWith({
    Color? appBar,
    Color? background,
    TextStyle? h1,
    TextStyle? h2,
    Color? surface,
  }) {
    return SimpleTheme(
      appBar: appBar ?? this.appBar,
      background: background ?? this.background,
      h1: h1 ?? this.h1,
      h2: h2 ?? this.h2,
      surface: surface ?? this.surface,
    );
  }

  @override
  ThemeExtension<SimpleTheme> lerp(other, t) {
    if (other is! SimpleTheme) return this;
    return SimpleTheme(
      appBar: _simpleLerp(appBar, other.appBar, t),
      background: _simpleLerp(background, other.background, t),
      h1: _simpleLerp(h1, other.h1, t),
      h2: _simpleLerp(h2, other.h2, t),
      surface: _simpleLerp(surface, other.surface, t),
    );
  }

  T _simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
}
