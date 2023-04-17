import 'package:example/tailor_mixin.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  late MixedTheme1 light;
  late MixedTheme1 dark;

  MixedTheme1 lightTheme() {
    return const MixedTheme1(
      foreground: Colors.white,
      textStyle: TextStyle(),
      ok: MixedTheme2(foreground: Colors.white),
    );
  }

  setUp(() {
    light = lightTheme();

    dark = light.copyWith(
      foreground: Colors.black,
      ok: light.ok.copyWith(foreground: Colors.black),
    );
  });

  group('TailorMixin()', () {
    test('copy with method', () {
      expect(dark.foreground, Colors.black);
      expect(dark.ok.foreground, Colors.black);
    });

    test('lerp method', () {
      expect(
        light.lerp(dark, 0.5).ok.foreground,
        Color.lerp(Colors.white, Colors.black, 0.5),
      );
    });

    test('hash code, equality', () {
      final lightCopy = light.copyWith();
      final light2 = lightTheme();

      expect(light == lightCopy, isTrue);
      expect(light.hashCode == lightCopy.hashCode, isTrue);

      expect(light2 == light, isTrue);
      expect(light2.hashCode == light.hashCode, isTrue);

      expect(light.copyWith(foreground: Colors.pink) == light, isFalse);
      expect(
        light.copyWith(foreground: Colors.pink).hashCode == light.hashCode,
        isFalse,
      );
    });
  });
}
