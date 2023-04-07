// ignore_for_file: directives_ordering

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'diagnosticable.tailor.dart';

@Tailor()
class _$MyTheme {
  static List<Color> background = [Colors.white, Colors.black];
  static List<TextStyle> textStyle = const [TextStyle(), TextStyle()];
}
