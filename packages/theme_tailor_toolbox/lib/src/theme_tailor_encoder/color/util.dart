import 'package:flutter/material.dart';

Color colorAlphaScale(Color a, double factor) {
  return a.withAlpha((a.alpha * factor).round().clamp(0, 255));
}
