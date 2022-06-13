import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme_extension_in_field.tailor.dart';

@tailor
class $_SomeTheme {
  static List<Color> appBackground = [AppColors.white, AppColors.black];
  static List<$_AnotherThemePart> anotherThemePart = [];
}

@tailor
class $_AnotherThemePart {
  static List<Color> navBarBackground = [AppColors.white, AppColors.black];
}
