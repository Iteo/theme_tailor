import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'themes_name_collision.tailor.dart';

@Tailor(generateStaticGetters: false)
class $_SimpleTheme {
  @themeExtension
  static List<AnotherTheme> anotherTheme = AnotherTheme.tailorThemes;
}

@tailorComponent
class $_AnotherTheme {
  static List<Color> themes = [Colors.amber, Colors.blueGrey.shade800];
}
