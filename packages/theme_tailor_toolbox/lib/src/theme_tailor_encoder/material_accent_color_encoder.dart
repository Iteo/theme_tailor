import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/util/color.dart';

/// ### MaterialAccentColorEncoder
/// The default implementations of the ThemeEncoder for MaterialAccentColor
///
/// {@macro tttoolbox.encoders.encoderUsage}
class MaterialAccentColorEncoder extends ThemeEncoder<MaterialAccentColor> {
  const MaterialAccentColorEncoder();

  @override
  MaterialAccentColor lerp(
    MaterialAccentColor a,
    MaterialAccentColor b,
    double t,
  ) {
    return lerpMaterialAccentColor(a, b, t)!;
  }
}

/// ### MaterialAccentColorNullableEncoder
/// The default implementations of the ThemeEncoder for MaterialAccentColor?
///
/// {@macro tttoolbox.encoders.encoderUsage}
class MaterialAccentColorNullableEncoder extends ThemeEncoder<MaterialAccentColor?> {
  const MaterialAccentColorNullableEncoder();

  @override
  MaterialAccentColor? lerp(
    MaterialAccentColor? a,
    MaterialAccentColor? b,
    double t,
  ) {
    return lerpMaterialAccentColor(a, b, t);
  }
}
