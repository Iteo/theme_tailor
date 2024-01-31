// ignore_for_file: annotate_overrides

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'typedef_example.tailor.dart';

typedef AnotherThemeType = List<AnotherTheme>;
typedef AnotherNullableThemeType = List<AnotherTheme?>;
typedef OtherThemeListType = List<OtherThemeExtension>;
typedef ListOfColorsType = List<Color>;

@tailorMixin
class SimpleTheme extends ThemeExtension<SimpleTheme>
    with _$SimpleThemeTailorMixin {
  @themeExtension
  static AnotherThemeType anotherTheme = [
    AnotherTheme(
      appBarColor: Colors.white,
      floatingActionButtonColor: [
        Colors.white,
        Colors.green,
      ],
    ),
  ];

  static OtherThemeListType otherThemeList = [
    OtherThemeExtension(),
    OtherThemeExtension(),
  ];

  @themeExtension
  static AnotherNullableThemeType anotherNullable = [
    null,
    null,
  ];
}

@tailorMixin
class AnotherTheme extends ThemeExtension<AnotherTheme>
    with _$AnotherThemeTailorMixin {
  AnotherTheme({
    required this.appBarColor,
    required this.floatingActionButtonColor,
  });

  final Color appBarColor;
  final ListOfColorsType floatingActionButtonColor;
}

@tailorMixinComponent
class OtherThemeExtension extends ThemeExtension<OtherThemeExtension> {
  OtherThemeExtension({
    this.floatingActionButtonColor = Colors.white,
  });

  final Color floatingActionButtonColor;

  @override
  OtherThemeExtension copyWith({Color? floatingActionButtonColor}) {
    return OtherThemeExtension(
        floatingActionButtonColor:
            floatingActionButtonColor ?? this.floatingActionButtonColor);
  }

  @override
  OtherThemeExtension lerp(
      ThemeExtension<OtherThemeExtension>? other, double t) {
    if (other is! OtherThemeExtension) return this;
    return OtherThemeExtension(
      floatingActionButtonColor: Color.lerp(
          floatingActionButtonColor, other.floatingActionButtonColor, t)!,
    );
  }
}
