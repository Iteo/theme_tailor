import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme_tailor_toolbox/src/util/color.dart';

import '../../random_values.dart';

typedef SwatchMap = Map<int, Color?>;

extension on ColorSwatch<int> {
  Color get primary => Color(value);
}

MaterialColor _randomMaterialColor([Random? random]) {
  final rnd = random ?? Random();
  final map = {50: randomColor(rnd)};
  for (var i = 100; i < 1000; i += 100) {
    map[i] = randomColor(rnd);
  }
  return MaterialColor(randomColor(rnd).value, map);
}

MaterialAccentColor _randomMaterialAccentColor([Random? random]) {
  final rnd = random ?? Random();
  return MaterialAccentColor(randomColor(rnd).value, {
    100: randomColor(rnd),
    200: randomColor(rnd),
    400: randomColor(rnd),
    700: randomColor(rnd),
  });
}

SwatchMap _materialColorsLerpSwatchMap(
    MaterialColor? a, MaterialColor? b, double t) {
  final map = {
    0: Color.lerp(a, b, t),
    50: Color.lerp(a?[50], b?[50], t),
  };
  for (var i = 100; i < 1000; i += 100) {
    map[i] = Color.lerp(a?[i], b?[i], t);
  }
  return map;
}

SwatchMap _materialAccentColorsLerpSwatchMap(
    MaterialAccentColor? a, MaterialAccentColor? b, double t) {
  final map = {
    0: Color.lerp(a, b, t),
    100: Color.lerp(a?[100], b?[100], t),
    200: Color.lerp(a?[200], b?[200], t),
    400: Color.lerp(a?[400], b?[400], t),
    700: Color.lerp(a?[700], b?[700], t),
  };
  return map;
}

SwatchMap _materialColorToSwatchMap(MaterialColor? color) {
  final map = {
    0: color?.primary,
    50: color?[50],
  };
  for (var i = 100; i < 1000; i += 100) {
    map[i] = color?[i];
  }
  return map;
}

SwatchMap _materialAccentColorToSwatchMap(MaterialAccentColor? color) {
  final map = {
    0: color?.primary,
    100: color?[100],
    200: color?[200],
    400: color?[400],
    700: color?[700],
  };
  return map;
}

void main() {
  test('lerpMaterialColor', () {
    final rnd = Random();
    expect(lerpMaterialColor(null, null, rnd.nextDouble()), null);

    for (var i = 0; i < 30; i++) {
      var t = rnd.nextDouble();
      var a = _randomMaterialColor(rnd);
      var b = _randomMaterialColor(rnd);

      expect(
        _materialColorToSwatchMap(lerpMaterialColor(a, b, t)),
        _materialColorsLerpSwatchMap(a, b, t),
      );
      expect(
        _materialColorToSwatchMap(lerpMaterialColor(a, null, t)),
        _materialColorsLerpSwatchMap(a, null, t),
      );
      expect(
        _materialColorToSwatchMap(lerpMaterialColor(null, b, t)),
        _materialColorsLerpSwatchMap(null, b, t),
      );
    }
  });

  test('lerpMaterialColor', () {
    final rnd = Random();
    expect(lerpMaterialAccentColor(null, null, rnd.nextDouble()), null);

    for (var i = 0; i < 30; i++) {
      var t = rnd.nextDouble();
      var a = _randomMaterialAccentColor(rnd);
      var b = _randomMaterialAccentColor(rnd);

      expect(
        _materialAccentColorToSwatchMap(lerpMaterialAccentColor(a, b, t)),
        _materialAccentColorsLerpSwatchMap(a, b, t),
      );
      expect(
        _materialAccentColorToSwatchMap(lerpMaterialAccentColor(a, null, t)),
        _materialAccentColorsLerpSwatchMap(a, null, t),
      );
      expect(
        _materialAccentColorToSwatchMap(lerpMaterialAccentColor(null, b, t)),
        _materialAccentColorsLerpSwatchMap(null, b, t),
      );
    }
  });
}
