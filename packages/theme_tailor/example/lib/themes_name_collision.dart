// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'themes_name_collision.tailor.dart';

@tailorMixin
class SimpleTheme extends ThemeExtension<SimpleTheme> with _$SimpleThemeTailorMixin {
  @themeExtension
  static List<AnotherTheme> anotherTheme = [
    const AnotherTheme(Colors.black),
    const AnotherTheme(Colors.white),
  ];
}

@tailorMixinComponent
class AnotherTheme extends ThemeExtension<AnotherTheme> with _$AnotherThemeTailorMixin {
  const AnotherTheme(this.foreground);

  final Color foreground;
}
