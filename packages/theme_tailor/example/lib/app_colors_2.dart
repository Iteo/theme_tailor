import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'app_colors_2.tailor.dart';

@Tailor(themes: ["light"], themeGetter: ThemeGetter.onBuildContext)
class _$AppColors2 {
  static List<Color> background = const [Color(0xFFFFFFFF)];
  static List<Color> onBackground = const [Color(0xFF3C3C3B)];
}
