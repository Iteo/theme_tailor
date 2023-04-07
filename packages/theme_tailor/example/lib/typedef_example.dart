import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'typedef_example.tailor.dart';

typedef AnotherThemeList = List<AnotherTheme>;
typedef AnotherNullableThemeList = List<AnotherTheme?>;
typedef OtherThemeList = List<OtherThemeExtension>;
typedef ListOfColors = List<Color>;

@tailor
class $_SimpleTheme {
  @themeExtension
  static AnotherThemeList anotherTheme = AnotherTheme.themes;

  static OtherThemeList otherThemeList = [
    OtherThemeExtension(),
    OtherThemeExtension(),
  ];

  @themeExtension
  static AnotherNullableThemeList anotherNullable = AnotherTheme.themes;
}

@tailor
class $_AnotherTheme {
  static List<Color> appBarColor = [Colors.amber, Colors.blueGrey.shade800];

  static ListOfColors floatingActionButtonColor = [Colors.white, Colors.green];
}

@tailorComponent
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
