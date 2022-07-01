import 'package:flutter/material.dart';

Color lerpColor(Color a, Color b, double t) => Color.lerp(a, b, t)!;

int lerpColorComponent(int a, int b, double t) =>
    lerpInt(a, b, t).clamp(0, 255).toInt();

double lerpInt(int a, int b, double t) => a + (b - a) * t;

Color colorAlphaScale(Color a, double factor) {
  return a.withAlpha((a.alpha * factor).round().clamp(0, 255));
}

ColorSwatch<int> lerpIntColorSwatch(
  final List<int> values,
  ColorSwatch<int> a,
  ColorSwatch<int> b,
  double t,
) {
  return ColorSwatch(
    lerpColorComponent(a.value, b.value, t),
    remapColorSwatch(values, (i) => lerpColor(a[i]!, b[i]!, t)),
  );
}

ColorSwatch changeColorSwatch(
  List<int> values,
  ColorSwatch<int> color,
  double t,
  Color Function(Color color, double t) transform,
) {
  return ColorSwatch(
    transform(color, t).value,
    remapColorSwatch(values, (i) => transform(color[i]!, t)),
  );
}

Map<int, T> remapColorSwatch<T>(List<int> values, T Function(int i) remap) {
  final map = <int, T>{};
  for (final val in values) {
    map[val] = remap(val);
  }
  return map;
}
