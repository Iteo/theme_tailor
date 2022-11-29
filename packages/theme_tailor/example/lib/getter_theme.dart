import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'getter_theme.tailor.dart';

@tailor
class $_GetterTheme {
  static const h1Style = TextStyle(fontSize: 15, color: Colors.grey);
  static const h2Style = TextStyle(fontSize: 14, color: Colors.black);

  static List<Color> get background => [Colors.white, Colors.grey.shade900];
  static const List<Color> appBar = [Colors.amber, Colors.blueGrey];
  static const h1 = [h1Style, h1Style];
  static const h2 = [h2Style, h2Style];
}

@Tailor(themes: ['light'])
class $_Theme1 {
  static const s1 = ['blue', 'red'];
}
