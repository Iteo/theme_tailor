// ignore_for_file: annotate_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'tailor_mixin.tailor.dart';

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme>
    with DiagnosticableTreeMixin, MyThemeTailorMixin {
  const MyTheme({
    required this.foreground,
    required this.textStyle,
    required this.ok,
    this.background,
  });

  final Color? background;
  final Color foreground;
  final TextStyle textStyle;
  final ButtonTheme ok;

  static final some = 'Something ${2 + 2}';
  static const calculations = '4';
}

@TailorMixin()
class ButtonTheme extends ThemeExtension<ButtonTheme>
    with ButtonThemeTailorMixin {
  const ButtonTheme({
    required this.foreground,
    required this.background,
  });

  final Color foreground;
  final Color background;
}

// mixin MyThemeTailorMixin on ThemeExtension<MyTheme>, DiagnosticableTreeMixin {
//   Color get background;
//   Color get foreground;
//   TextStyle get textStyle;

//   @override
//   ThemeExtension<MyTheme> copyWith({
//     Color? background,
//     Color? foreground,
//     TextStyle? textStyle,
//   }) {
//     return MyTheme(
//       background: background ?? this.background,
//       foreground: foreground ?? this.foreground,
//       textStyle: textStyle ?? this.textStyle,
//     );
//   }

//   @override
//   ThemeExtension<MyTheme> lerp(
//     covariant ThemeExtension<MyTheme>? other,
//     double t,
//   ) {
//     if (other is! MyTheme) return this;
//     return MyTheme(
//       background: Color.lerp(background, other.background, t)!,
//       foreground: Color.lerp(foreground, other.foreground, t)!,
//       textStyle: TextStyle.lerp(textStyle, other.textStyle, t)!,
//     );
//   }

//   @override
//   void debugFillProperties(DiagnosticPropertiesBuilder properties) {
//     super.debugFillProperties(properties);
//     properties
//       ..add(DiagnosticsProperty('type', 'ButtonTheme'))
//       ..add(DiagnosticsProperty('bg', background))
//       ..add(DiagnosticsProperty('textStyle', textStyle));
//   }
// }

// extension NewSyntaxThemeProps on BuildContext {
//   MyTheme get myTheme => Theme.of(this).extension<MyTheme>()!;
// }
