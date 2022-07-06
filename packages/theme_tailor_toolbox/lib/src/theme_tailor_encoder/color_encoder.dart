import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// ### ColorEncoder
/// The default implementations of the ThemeEncoder for `Color`
///
/// {@template tttoolbox.encoders.encoderUsage}
/// Each of the encoders handles only one exact type. Encoder type must match
/// the field type.\
/// Use `NoLerpEncoder<T>` to prevent interpolation
/// {@endtemplate}
class ColorEncoder extends ThemeEncoder<Color> {
  const ColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}

/// ### ColorNullableEncoder
/// The default implementations of the ThemeEncoder for `Color?`
///
/// {@macro tttoolbox.encoders.encoderUsage}
class ColorNullableEncoder extends ThemeEncoder<Color?> {
  const ColorNullableEncoder();

  @override
  Color? lerp(Color? a, Color? b, double t) => Color.lerp(a, b, t);
}
