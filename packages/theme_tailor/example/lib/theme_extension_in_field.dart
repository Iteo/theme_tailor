// ignore_for_file: annotate_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme_extension_in_field.tailor.dart';

@tailorMixin
class SomeTheme extends ThemeExtension<SomeTheme>
    with DiagnosticableTreeMixin, _$SomeThemeTailorMixin {
  SomeTheme(this.appBackground);

  final Color appBackground;

  @themeExtension
  static AnotherThemePart anotherThemePartGeneratedConstructor =
      AnotherThemePart(Colors.green);

  static List<OtherThemeExtension> otherThemeExtension = [
    OtherThemeExtension(),
    OtherThemeExtension()
  ];

  @themeExtension
  static List<AnotherThemePart?> nullablePart = List.filled(2, null);

  static List<OtherThemeExtension?> nullableOtherTheme = List.filled(3, null);
}

@tailorMixinComponent
class AnotherThemePart extends ThemeExtension<AnotherThemePart>
    with _$AnotherThemePartTailorMixin {
  AnotherThemePart(this.navBarBackground);

  final Color navBarBackground;
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
