import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/util/lerp_color.dart';

import 'package:theme_tailor_toolbox/src/util/lerp_material_color.dart';

class MaterialColorEncoder extends ThemeEncoder<MaterialColor> {
  @override
  MaterialColor lerp(MaterialColor a, MaterialColor b, double t) {
    return lerpMaterialColor(a, b, t);
  }
}

class MaterialColorNullEncoder extends ThemeEncoder<MaterialColor?> {
  MaterialColor _alphaTransform(
    MaterialColor color,
    double t,
    Color Function(Color color, double t) transform,
  ) {
    final swatch = <int, Color>{};
    for (final value in materialColorsValues) {
      swatch[value] = transform(color[value]!, t);
    }
    return MaterialColor(transform(color, t).value, swatch);
  }

  @override
  MaterialColor? lerp(MaterialColor? a, MaterialColor? b, double t) {
    if (b == null) {
      if (a == null) {
        return null;
      }
      Color transform(Color a, double t) => colorAlphaScale(a, 1 - t);

      // final swatch = <int, Color>{};
      // for (final value in materialColorsValues) {
      //   swatch[value] = transform(a[value]!);
      // }
      // return MaterialColor(transform(a).value, swatch);
      return _alphaTransform(a, 2, transform);
    }
    if (a == null) {
      Color transform(Color b) => colorAlphaScale(b, t);

      final swatch = <int, Color>{};
      for (final value in materialColorsValues) {
        swatch[value] = transform(b[value]!);
      }
      return MaterialColor(transform(b).value, swatch);
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
