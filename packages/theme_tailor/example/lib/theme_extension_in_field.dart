import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme_extension_in_field.tailor.dart';

@Tailor(generateStaticGetters: false)
class $_SomeTheme {
  static List<Color> appBackground = [AppColors.white, AppColors.black];
  @themeExtension
  static List<AnotherThemePart> anotherThemePart = [
    AnotherThemePart.light,
    AnotherThemePart.dark,
  ];

  @themeExtension
  static List<AnotherThemePart> anotherThemePartGeneratedConstructor =
      AnotherThemePart.themes;

  static List<OtherThemeExtension> otherThemeExtension = [
    OtherThemeExtension(),
    OtherThemeExtension()
  ];

  @themeExtension
  static List<AnotherThemePart?> nullablePart =
      List.filled(SomeTheme.themes.length, null);

  static List<OtherThemeExtension?> nullableOtherTheme =
      List.filled(SomeTheme.themes.length, null);
}

@tailorComponent
class $_AnotherThemePart {
  static List<Color> navBarBackground = [AppColors.white, AppColors.black];
}

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
