import 'package:flutter/material.dart';

Color lerpColor(Color a, Color b, double t) => Color.fromARGB(
      lerpColorComponent(a.alpha, b.alpha, t),
      lerpColorComponent(a.red, b.red, t),
      lerpColorComponent(a.green, b.green, t),
      lerpColorComponent(a.blue, b.blue, t),
    );

int lerpColorComponent(int a, int b, double t) =>
    lerpInt(a, b, t).clamp(0, 255).toInt();

double lerpInt(int a, int b, double t) => a + (b - a) * t;

Color colorAlphaScale(Color a, double factor) {
  return a.withAlpha((a.alpha * factor).round().clamp(0, 255));
}
