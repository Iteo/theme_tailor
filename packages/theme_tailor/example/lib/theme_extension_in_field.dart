import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme_extension_in_field.tailor.dart';

@tailor
class $_SomeTheme {
  static List<Color> appBackground = [AppColors.white, AppColors.black];
  static List<$_AnotherThemePart> anotherThemePart = [AnotherThemePart.light, AnotherThemePart.dark];
  static List<$_AnotherThemePart> anotherThemePartGeneratedConstructor = AnotherThemePart.themes;
  static List<OtherThemeExtension> otherThemeExtension = [OtherThemeExtension(), OtherThemeExtension()];
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
    return OtherThemeExtension(floatingActionButtonColor: floatingActionButtonColor ?? this.floatingActionButtonColor);
  }

  @override
  OtherThemeExtension lerp(ThemeExtension<OtherThemeExtension>? other, double t) {
    if (other is! OtherThemeExtension) return this;
    return OtherThemeExtension(
      floatingActionButtonColor: t < 0.5 ? floatingActionButtonColor : other.floatingActionButtonColor,
    );
  }
}
