import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const colorEncoder = ColorEncoder();
const colorNullEncoder = ColorNullEncoder();

class ColorEncoder extends ThemeEncoder<Color> {
  const ColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}

class ColorNullEncoder extends ThemeEncoder<Color?> {
  const ColorNullEncoder();

  @override
  Color? lerp(Color? a, Color? b, double t) => Color.lerp(a, b, t);
}
