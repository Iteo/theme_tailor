// ignore_for_file: annotate_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'tailor_mixin.tailor.dart';

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme>
    with DiagnosticableTreeMixin, MyThemeTailorMixin {
  const MyTheme({
    required this.foreground,
    required this.textStyle,
    required this.ok,
    this.background,
  });

  final Color? background;
  final Color foreground;
  final TextStyle textStyle;
  final ButtonTheme ok;

  static final some = 'Something ${2 + 2}';
  static const calculations = '4';
}

@TailorMixin()
class ButtonTheme extends ThemeExtension<ButtonTheme>
    with ButtonThemeTailorMixin {
  const ButtonTheme({
    required this.foreground,
    required this.background,
  });

  final Color foreground;
  final Color background;
}
