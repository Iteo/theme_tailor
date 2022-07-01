import 'package:flutter/material.dart';

import 'lerp_color.dart';

const materialColorsValues = [50, 100, 200, 300, 400, 500, 600, 700, 800, 900];
const materialAccentColorsValues = [100, 200, 400, 700];

MaterialColor lerpMaterialColor(MaterialColor a, MaterialColor b, double t) {
  return MaterialColor(
    lerpColorComponent(a.value, b.value, t),
    lerpColorSwatch(materialColorsValues, a, b, t),
  );
}

MaterialAccentColor lerpMaterialAccentColor(
  MaterialAccentColor a,
  MaterialAccentColor b,
  double t,
) {
  return MaterialAccentColor(
    lerpColorComponent(a.value, b.value, t),
    lerpColorSwatch(materialAccentColorsValues, a, b, t),
  );
}

Map<int, Color> lerpColorSwatch(
  List<int> values,
  ColorSwatch a,
  ColorSwatch b,
  double t,
) {
  final map = <int, Color>{};
  for (final val in values) {
    map[val] = lerpColor(a[val]!, b[val]!, t);
  }
  return map;
}

Map<int, Color?>? lerpColorSwatchNull(
  List<int> values,
  ColorSwatch? a,
  ColorSwatch? b,
  double t,
) {
  if (b == null) {
    if (a == null) {
      return null;
    }

    final map = <int, Color>{};
    for (final val in values) {
      map[val] = colorAlphaScale(a, 1.0 - t);
    }
    return map;
  }

  if (a == null) {
    final map = <int, Color>{};
    for (final val in values) {
      map[val] = colorAlphaScale(b, t);
    }
    return map;
  }

  return lerpColorSwatch(values, a, b, t);
}

Map<int, T> swatchTransform<T, T2>(
  List<int> values,
  Map<int, T> a,
  Map<int, T> b,
  double t,
  T Function(T a, T b, double t) transform,
) {
  final map = <int, T>{};
  for (final val in values) {
    map[val] = transform(a[val]!, b[val]!, t);
  }
  return map;
}
