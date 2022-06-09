import 'dart:math' as math;
import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'encoder_example.tailor.dart';

class TextStyleEncoder extends ThemeEncoder<TextStyle> {
  const TextStyleEncoder();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) {
    return TextStyle.lerp(a, b, t)!;
  }
}

class CustomColorEncoder extends ThemeEncoder<Color> {
  const CustomColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) {
    return Color.fromARGB(
      _lerpColorComponent(a.alpha, b.alpha, t),
      _lerpColorComponent(a.red, b.red, t),
      _lerpColorComponent(a.green, b.green, t),
      _lerpColorComponent(a.blue, b.blue, t),
    );
  }

  int _lerpColorComponent(int a, int b, double t) {
    return _clampInt(_lerpInt(a, b, t), 0, 255);
  }

  double _lerpInt(int a, int b, double t) => a + (b - a) * t;

  int _clampInt(double value, int min, int max) {
    return math.max(min, math.min(max, value.toInt()));
  }
}

/// Use @Tailor annotation to declare custom themes or different
/// quantity of themes than the default 2 (light and dark)
@Tailor(themes: ['superLight', 'amoledDark'])
class $_Theme1 {
  @CustomColorEncoder()
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  @TextStyleEncoder()
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}

const customColorEncoder = CustomColorEncoder();
const textStyleEncoder = TextStyleEncoder();

@Tailor(themes: ['superLight', 'amoledDark'])
class $_Theme2 {
  @customColorEncoder
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  @textStyleEncoder
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}

@Tailor(
  themes: ['superLight', 'amoledDark'],
  encoders: [CustomColorEncoder(), TextStyleEncoder()],
)
class $_Theme3 {
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}

const tailorWithEncoders = Tailor(
  themes: ['superLight', 'amoledDark'],
  encoders: [customColorEncoder, textStyleEncoder],
);

@tailorWithEncoders
class $_Theme4 {
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}
