import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'extensions_getters_example.tailor.dart';

@Tailor(themes: ['light'], themeGetter: ThemeGetter.none)
class $_ExtensionGettersExample1 {
  static const List<Color> surface = [Colors.pink];
}

@Tailor(themes: ['light'], themeGetter: ThemeGetter.onBuildContext)
class $_ExtensionGettersExample2 {
  static const List<Color> surface = [Colors.red];
}

@Tailor(themes: ['light'], themeGetter: ThemeGetter.onBuildContextProps)
class $_ExtensionGettersExample3 {
  static const List<Color> surface = [Colors.amber];
}

@Tailor(themes: ['light'], themeGetter: ThemeGetter.onThemeData)
class $_ExtensionGettersExample4 {
  static const List<Color> surface = [Colors.blue];
}

@Tailor(themes: ['light'], themeGetter: ThemeGetter.onThemeDataProps)
class $_ExtensionGettersExample5 {
  static const List<Color> surface = [Colors.purple];
}
