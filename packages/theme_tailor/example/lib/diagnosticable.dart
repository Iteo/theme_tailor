// ignore_for_file: directives_ordering
// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'diagnosticable.tailor.dart';

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme> with DiagnosticableTreeMixin, _$MyThemeTailorMixin {
  MyTheme({
    required this.background,
    required this.textStyle,
  });

  final Color background;
  final TextStyle textStyle;
}

@TailorMixin()
class EmptyTheme extends ThemeExtension<EmptyTheme> with _$EmptyThemeTailorMixin {}
