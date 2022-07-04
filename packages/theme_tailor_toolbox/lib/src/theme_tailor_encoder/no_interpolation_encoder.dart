import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const colorNoLerpEncoder = NoIntepolationEncoder<Color>;
const colorNullNoLerpEncoder = NoIntepolationEncoder<Color?>;

const materialColorNoLerpEncoder = NoIntepolationEncoder<MaterialColor>();
const materialColorNullNoLerpEncoder = NoIntepolationEncoder<MaterialColor?>();

const materialAccentColorNoLerpEncoder =
    NoIntepolationEncoder<MaterialAccentColor>();
const materialAccentColorNullNoLerpEncoder =
    NoIntepolationEncoder<MaterialAccentColor?>();

class NoIntepolationEncoder<T> extends ThemeEncoder<T> {
  const NoIntepolationEncoder();

  @override
  T lerp(T a, T b, double t) => t < 0.5 ? a : b;
}
