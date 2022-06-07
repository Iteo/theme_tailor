import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'simple_theme.tailor.dart';

const _lol = [AppColors.blue, AppColors.orange];

class CustomColorEncoder extends SimpleThemeEncoder<Color> {
  const CustomColorEncoder();
}

class CustomColorEncoder2 extends SimpleThemeEncoder<Color> {
  const CustomColorEncoder2();
}

class CustomIntEncoder extends SimpleThemeEncoder<int> {
  const CustomIntEncoder();
}

class TextStyleEncoder extends SimpleThemeEncoder<TextStyle> {
  const TextStyleEncoder();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) => TextStyle.lerp(a, b, t)!;
}

const customIntEncoder = CustomIntEncoder();
const customColorEncoder = CustomColorEncoder();
const customColorEncoder2 = CustomColorEncoder2();
const textStyleEncoder = TextStyleEncoder();

/// Use @tailor annotation with default values of ['light', 'dark']
@tailor
class $_SimpleTheme {
  static List<Color> background = [AppColors.white, AppColors.yellow];
  static List<Color> surface = _lol;
  static List<Color> appBar = [AppColors.orange, AppColors.blue];
  static List<TextStyle> h1 = const [TextStyle(color: AppColors.black), TextStyle(color: AppColors.orange)];
  static List<TextStyle> h2 = const [TextStyle(color: AppColors.orange), TextStyle(color: AppColors.black)];
}

/// Use @Tailor annotation to declare custom themes or different
/// quantity of themes than the default 2 (light and dark)
@Tailor(themes: ['superLight', 'amoledDark'], encoders: [customColorEncoder])
class $_SimpleThemeVariant2 {
  static List background = [AppColors.white, AppColors.black];
  static List<Color?> surface = _lol;

  static List<Color> appBar = [AppColors.orange, AppColors.blue];

  @CustomColorEncoder2()
  static List<Color> appBar2 = [AppColors.orange, AppColors.blue];

  @CustomColorEncoder()
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  @textStyleEncoder
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}
