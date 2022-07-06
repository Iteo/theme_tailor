import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

abstract class ColorEncoder {
  const factory ColorEncoder() = ColorEncoderImpl;
  const factory ColorEncoder.nullable() = ColorEncoderNullableImpl;
}

class ColorEncoderImpl extends ThemeEncoder<Color> implements ColorEncoder {
  const ColorEncoderImpl();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}

class ColorEncoderNullableImpl extends ThemeEncoder<Color?>
    implements ColorEncoder {
  const ColorEncoderNullableImpl();

  @override
  Color? lerp(Color? a, Color? b, double t) => Color.lerp(a, b, t);
}
