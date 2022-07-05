import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

const colorNullEncoder = ColorNullEncoder();
const colorNullEncoderNoLerp = ColorNullEncoderNoLerp();

class ColorNullEncoder extends ThemeEncoder<Color?> {
  const ColorNullEncoder();

  @override
  Color? lerp(Color? a, Color? b, double t) => Color.lerp(a, b, t);
}

class ColorNullEncoderNoLerp extends NoLerpEncoder<Color?> {
  const ColorNullEncoderNoLerp();
}
