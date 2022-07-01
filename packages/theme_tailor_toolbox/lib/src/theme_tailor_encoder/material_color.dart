import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/util.dart';

const materialColorsValues = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
const materialAccentColorsValues = [100, 200, 400, 700];

MaterialColor lerpMaterialColor(MaterialColor a, MaterialColor b, double t) {
  return lerpIntColorSwatch(materialColorsValues, a, b, t) as MaterialColor;
}

MaterialAccentColor lerpMaterialAccentColor(
  MaterialAccentColor a,
  MaterialAccentColor b,
  double t,
) {
  return lerpIntColorSwatch(materialAccentColorsValues, a, b, t)
      as MaterialAccentColor;
}

class MaterialColorEncoder extends ThemeEncoder<MaterialColor> {
  @override
  MaterialColor lerp(MaterialColor a, MaterialColor b, double t) {
    return lerpMaterialColor(a, b, t);
  }
}

class MaterialColorNullEncoder extends ThemeEncoder<MaterialColor?> {
  MaterialColor _transform(
    MaterialColor color,
    double t,
    Color Function(Color color, double t) transform,
  ) {
    return changeColorSwatch(materialColorsValues, color, t, transform)
        as MaterialColor;
  }

  @override
  MaterialColor? lerp(MaterialColor? a, MaterialColor? b, double t) {
    if (b == null) {
      if (a == null) {
        return null;
      }
      Color transform(Color a, double t) => colorAlphaScale(a, 1 - t);
      return _transform(a, 2, transform);
    }
    if (a == null) {
      Color transform(Color b, double t) => colorAlphaScale(b, t);
      return _transform(b, 2, transform);
    }
    return lerpMaterialColor(a, b, t);
  }
}

class MaterialAccentColorEncoder extends ThemeEncoder<MaterialAccentColor> {
  @override
  MaterialAccentColor lerp(
    MaterialAccentColor a,
    MaterialAccentColor b,
    double t,
  ) {
    return lerpMaterialAccentColor(a, b, t);
  }
}

class MaterialAccentColorNullEncoder
    extends ThemeEncoder<MaterialAccentColor?> {
  MaterialAccentColor _transform(
    MaterialAccentColor color,
    double t,
    Color Function(Color color, double t) transform,
  ) {
    return changeColorSwatch(materialColorsValues, color, t, transform)
        as MaterialAccentColor;
  }

  @override
  MaterialAccentColor? lerp(
      MaterialAccentColor? a, MaterialAccentColor? b, double t) {
    if (b == null) {
      if (a == null) {
        return null;
      }
      Color transform(Color a, double t) => colorAlphaScale(a, 1 - t);
      return _transform(a, 2, transform);
    }
    if (a == null) {
      Color transform(Color b, double t) => colorAlphaScale(b, t);
      return _transform(b, 2, transform);
    }
    return lerpMaterialAccentColor(a, b, t);
  }
}
