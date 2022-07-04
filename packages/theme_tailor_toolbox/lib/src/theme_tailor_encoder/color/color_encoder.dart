import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

import '../no_interpolation_encoder.dart';

const colorEncoder = ColorEncoder();
const colorEncoderNoLerp = ColorEncoderNoLerp();

class ColorEncoder extends ThemeEncoder<Color> {
  const ColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}

class ColorEncoderNoLerp extends NoLerpEncoder<Color> {
  const ColorEncoderNoLerp();
}
