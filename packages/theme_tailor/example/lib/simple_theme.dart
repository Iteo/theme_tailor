import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'app_colors.dart';

part 'simple_theme.tailor.dart';

const _lol = [AppColors.blue, AppColors.orange];

@Tailor(['light', 'dark'])
class $_SimpleTheme {
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> surface = _lol;
  static List<Color> appBar = [AppColors.orange, AppColors.blue];
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}
