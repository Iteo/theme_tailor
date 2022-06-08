import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'simple_theme.tailor.dart';

const _sampleColors = [AppColors.blue, AppColors.orange];

/// Use @tailor annotation with default values of ['light', 'dark']
@tailor
class $_BaseTheme {
  static List<Color> a = [Colors.white, Colors.black];
}

@Tailor(themeGetter: ThemeGetter.onBuildContext)
class $_SimpleTheme {
  static List<Color> background = [AppColors.white, AppColors.yellow];
  static List<Color> surface = _sampleColors;
  static List<Color> appBar = [AppColors.orange, AppColors.blue];
  static List<TextStyle> h1 = const [
    TextStyle(color: AppColors.black),
    TextStyle(color: AppColors.orange)
  ];
  static List<TextStyle> h2 = const [
    TextStyle(color: AppColors.orange),
    TextStyle(color: AppColors.black)
  ];
}

/// Use @Tailor annotation to declare custom themes or different
/// quantity of themes than the default 2 (light and dark)
@Tailor(themes: ['superLight', 'amoledDark'])
class $_SimpleThemeVariant2 {
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> surface = _sampleColors;
  static List<Color> appBar = [AppColors.orange, AppColors.blue];
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}
