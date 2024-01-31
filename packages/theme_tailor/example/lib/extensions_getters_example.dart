// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'extensions_getters_example.tailor.dart';

@TailorMixin(themeGetter: ThemeGetter.none)
class ExtensionGettersExample1 extends ThemeExtension<ExtensionGettersExample1>
    with _$ExtensionGettersExample1TailorMixin {
  ExtensionGettersExample1(this.surface);

  final Color surface;
}

@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class ExtensionGettersExample2 extends ThemeExtension<ExtensionGettersExample2>
    with _$ExtensionGettersExample2TailorMixin {
  ExtensionGettersExample2(this.surface);

  final Color surface;
}

@TailorMixin(themeGetter: ThemeGetter.onBuildContextProps)
class ExtensionGettersExample3 extends ThemeExtension<ExtensionGettersExample3>
    with _$ExtensionGettersExample3TailorMixin {
  ExtensionGettersExample3(this.surface);

  final Color surface;
}

@TailorMixin(themeGetter: ThemeGetter.onThemeData)
class ExtensionGettersExample4 extends ThemeExtension<ExtensionGettersExample4>
    with _$ExtensionGettersExample4TailorMixin {
  ExtensionGettersExample4(this.surface);

  final Color surface;
}

@TailorMixin(themeGetter: ThemeGetter.onThemeDataProps)
class ExtensionGettersExample5 extends ThemeExtension<ExtensionGettersExample5>
    with _$ExtensionGettersExample5TailorMixin {
  ExtensionGettersExample5(this.surface);

  final Color surface;
}

/// Usage of theme extension
Map<String, ThemeData> themes = {
  'light': ThemeData(
    extensions: [
      ExtensionGettersExample1(Colors.white),
      ExtensionGettersExample2(Colors.white),
      ExtensionGettersExample3(Colors.white),
      ExtensionGettersExample4(Colors.white),
    ],
  ),
  'dark': ThemeData(
    extensions: [
      ExtensionGettersExample1(Colors.black),
      ExtensionGettersExample2(Colors.black),
      ExtensionGettersExample3(Colors.black),
      ExtensionGettersExample4(Colors.black),
    ],
  ),
};
