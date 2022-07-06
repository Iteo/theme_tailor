import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// ### TextStyleEncoder
/// The default implementations of the ThemeEncoder for TextStyle
///
/// {@macro tttoolbox.encoders.encoderUsage}
class TextStyleEncoder extends ThemeEncoder<TextStyle> {
  const TextStyleEncoder();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) {
    return TextStyle.lerp(a, b, t)!;
  }
}

/// ### TextStyleNullableEncoder
/// The default implementations of the ThemeEncoder for TextStyle?
///
/// {@macro tttoolbox.encoders.encoderUsage}
class TextStyleNullableEncoder extends ThemeEncoder<TextStyle?> {
  const TextStyleNullableEncoder();

  @override
  TextStyle? lerp(TextStyle? a, TextStyle? b, double t) {
    return TextStyle.lerp(a, b, t);
  }
}
