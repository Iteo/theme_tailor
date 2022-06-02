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
abstract class $_OK {
  List<Color> get background => [AppColors.white, AppColors.black];
  List<Color> get surface => lol;
  List<Color> get appBar => [AppColors.orange, AppColors.blue];

  @ColorVariant('primary', [Colors.black, Colors.black54])
  @ColorVariant('secondary', [Colors.blue, Colors.pink])
  @ColorVariant('onError', [Colors.white, Colors.white])
  List<TextStyle> get h1 => const [TextStyle(), TextStyle()];
  List<TextStyle> get h2 => const [TextStyle(), TextStyle()];
}
