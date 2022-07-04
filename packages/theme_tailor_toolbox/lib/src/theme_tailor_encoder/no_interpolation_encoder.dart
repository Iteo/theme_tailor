import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const colorNoLerpEncoder = ColorEncoderNoLerp();
const colorNullNoLerpEncoder = ColorNullEncoderNoLerp();

const materialColorNoLerpEncoder = MaterialColorEncoder();
const materialColorNullNoLerpEncoder = MaterialColorNullEncoder();

const materialAccentColorNoLerpEncoder = MaterialAccentColorEncoder();
const materialAccentColorNullNoLerpEncoder = MaterialAccentColorNullEncoder();

abstract class NoIntepolationEncoder<T> extends ThemeEncoder<T> {
  const NoIntepolationEncoder();

  @override
  T lerp(T a, T b, double t) => t < 0.5 ? a : b;
}

class ColorEncoderNoLerp extends NoIntepolationEncoder<Color> {
  const ColorEncoderNoLerp();
}

class ColorNullEncoderNoLerp extends NoIntepolationEncoder<Color?> {
  const ColorNullEncoderNoLerp();
}

class MaterialColorEncoder extends NoIntepolationEncoder<MaterialColor> {
  const MaterialColorEncoder();
}

class MaterialColorNullEncoder extends NoIntepolationEncoder<MaterialColor?> {
  const MaterialColorNullEncoder();
}

class MaterialAccentColorEncoder
    extends NoIntepolationEncoder<MaterialAccentColor> {
  const MaterialAccentColorEncoder();
}

class MaterialAccentColorNullEncoder
    extends NoIntepolationEncoder<MaterialAccentColor?> {
  const MaterialAccentColorNullEncoder();
}
