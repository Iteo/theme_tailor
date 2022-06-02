import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'main.tailor.dart';

class AppColors {
  static const Color orange = Colors.orange;
  static const Color blue = Colors.blue;
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);
}

const lol = [AppColors.blue, AppColors.orange];

@Tailor(['light', 'dark'])
class $_OK {
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> surface = lol;
  static List<Color> appBar = [AppColors.orange, AppColors.blue];

  @ColorVariant('primary', [Colors.black, Colors.black54])
  @ColorVariant('secondary', [Colors.blue, Colors.pink])
  @ColorVariant('onError', [Colors.white, Colors.white])
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle> h2 = const [TextStyle(), TextStyle()];
}
