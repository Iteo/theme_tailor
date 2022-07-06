import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/util/color.dart';

/// ### MaterialColorEncoder
/// The default implementations of the ThemeEncoder for MaterialColor
///
/// {@macro tttoolbox.encoders.encoderUsage}
class MaterialColorEncoder extends ThemeEncoder<MaterialColor> {
  const MaterialColorEncoder();

  @override
  MaterialColor lerp(MaterialColor a, MaterialColor b, double t) =>
      lerpMaterialColor(a, b, t)!;
}

/// ### MaterialColorNullableEncoder
/// The default implementations of the ThemeEncoder for MaterialColor?
///
/// {@macro tttoolbox.encoders.encoderUsage}
class MaterialColorNullableEncoder extends ThemeEncoder<MaterialColor?> {
  const MaterialColorNullableEncoder();

  @override
  MaterialColor? lerp(MaterialColor? a, MaterialColor? b, double t) =>
      lerpMaterialColor(a, b, t);
}
