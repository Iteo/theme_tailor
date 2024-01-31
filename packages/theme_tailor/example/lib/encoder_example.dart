// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'encoder_example.tailor.dart';

class TextStyleEncoder extends ThemeEncoder<TextStyle> {
  const TextStyleEncoder();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) =>
      TextStyle.lerp(a, b, t)!;
}

class TextStyleNullableEncoder extends ThemeEncoder<TextStyle?> {
  const TextStyleNullableEncoder();

  @override
  TextStyle? lerp(TextStyle? a, TextStyle? b, double t) =>
      TextStyle.lerp(a, b, t);
}

class CustomColorEncoder extends ThemeEncoder<Color> {
  const CustomColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}

/// Use @Tailor annotation to declare custom themes or different
/// quantity of themes than the default 2 (light and dark)
@TailorMixin()
class Theme1 extends ThemeExtension<Theme1> with _$Theme1TailorMixin {
  Theme1({
    required this.background,
    required this.iconColor,
    required this.h1,
    required this.h2,
  });

  @CustomColorEncoder()
  final Color background;
  final Color iconColor;

  @TextStyleEncoder()
  final TextStyle h1;

  @TextStyleNullableEncoder()
  final TextStyle? h2;
}

@TailorMixin(
  encoders: [
    CustomColorEncoder(),
    TextStyleEncoder(),
    TextStyleNullableEncoder(),
  ],
)
class Theme2 extends ThemeExtension<Theme2> with _$Theme2TailorMixin {
  Theme2({
    required this.background,
    required this.iconColor,
    required this.h1,
    required this.h2,
  });

  final Color background;
  final Color iconColor;
  final TextStyle h1;
  final TextStyle? h2;
}

@TailorMixin()
@CustomColorEncoder()
@TextStyleEncoder()
@TextStyleNullableEncoder()
class Theme3 extends ThemeExtension<Theme3> with _$Theme3TailorMixin {
  Theme3({
    required this.background,
    required this.iconColor,
    required this.h1,
    required this.h2,
  });

  final Color background;
  final Color iconColor;
  final TextStyle h1;
  final TextStyle? h2;
}

const appTailorMixin = TailorMixin(themeGetter: ThemeGetter.onBuildContext);

@appTailorMixin
@CustomColorEncoder()
@TextStyleEncoder()
@TextStyleNullableEncoder()
class Theme4 extends ThemeExtension<Theme4> with _$Theme4TailorMixin {
  Theme4({
    required this.background,
    required this.iconColor,
    required this.h1,
    required this.h2,
  });

  final Color background;
  final Color iconColor;
  final TextStyle h1;
  final TextStyle? h2;
}
