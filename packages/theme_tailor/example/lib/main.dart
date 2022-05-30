// ignore_for_file: unused_element

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'main.tailor.dart';

/// Define your colors somewhere in the app
class AppColors {
  static const Color blue = Colors.blue;
  static const Color orange = Colors.orange;
}

/// EXAMPLES
/// **************************************************************************
/// Default theme - default definition [@tailor] generates theme with 2 modes:
/// light and dark and 2 properties: [int] and [String] properties.
/// Without further customization it is not useful

// @tailor
// class _$DefaultTheme {}

// **************************************************************************
/// Default theme - light / dark with additional fields
/// h1 - text style
/// appBar - with different colors per mode (light: blue, dark: orange)

// @Tailor([
//   TailorProp('h1', [TextStyle(), TextStyle()]),
//   TailorProp('appBar', [AppColors.blue, AppColors.orange]),
//   TailorProp('card', [AppColors.blue, AppColors.orange]),
//   TailorProp('surface', [AppColors.blue, AppColors.orange]),
//   TailorProp('material', [AppColors.blue, AppColors.orange])
// ])
// class _$ThemeWithColorsAndTextStyles {}

// **************************************************************************
/// DOC

class ColorEncoder extends SimpleThemeEncoder<MaterialColor> {
  const ColorEncoder();

  @override
  Lerp<MaterialColor> get lerp => (a, b, t) => t < 0.5 ? a : b;

  @override
  Stringify<MaterialColor> get stringify => (v) => v.toString();
}

// @Tailor([
//   TailorProp('appBar', [AppColors.blue, AppColors.orange],
//       encoder: ColorEncoder())
// ])
// class _$ThemeWithColorsAndTextStylesCustomEncoder {}

// **************************************************************************
/// DOC - Multitheme, custom encoders

enum SuperThemeEnum {
  light,
  superLight,
  dark,
  superDark,
}

class SuperThemeEnumEncoder extends SimpleThemeEncoder<SuperThemeEnum> {
  const SuperThemeEnumEncoder();

  @override
  Lerp<SuperThemeEnum> get lerp => (a, b, t) => t < 0.5 ? a : b;

  @override
  Stringify<SuperThemeEnum> get stringify =>
      (v) => '${v.name} index: ${v.index}';
}

const themes = ['light', 'superLight', 'dark', 'superDark'];
const themesEnums = [
  SuperThemeEnum.light,
  SuperThemeEnum.superLight,
  SuperThemeEnum.dark,
  SuperThemeEnum.superDark
];

/// Multiple themes
// @Tailor([
//   TailorProp('themeType', themesEnums),
//   TailorProp('themeType2', themesEnums, encoder: SuperThemeEnumEncoder()),
// ], themes)
// class _$SuperThemeEnumThemeExtension {}

// **************************************************************************
/// DOC - Custom encoders

class NumerEncoder extends ThemeEncoder<int, double> {
  const NumerEncoder();

  @override
  Lerp<double> get lerp => (a, b, t) => lerpDouble(a, b, t)!;

  @override
  Stringify<double> get stringify => (v) => v.toString();

  @override
  TransformData<int, double>? get transformData => (v, _) => v.toDouble();
}

/// Custom data to encode in prefered format
class TextData {
  const TextData({
    this.fontFamily,
    this.size,
    this.lineHeight,
    this.spacing,
    this.fontWeight,
    this.defaultColor,
  });

  final String? fontFamily;
  final double? size;
  final double? lineHeight;
  final double? spacing;
  final int? fontWeight;
  final Color? defaultColor;

  static const h3 = TextData(defaultColor: AppColors.orange);

  TextStyle toTextStyle(Color color) => TextStyle(color: color);
}

/// Encoder to transform data before it is encoded to theme
/// During data transformation, custom properties can be encoded from the
/// [TextDataEncoder.colors] in the [TextDataEncoder.transformData]
class TextDataEncoder extends ThemeEncoder<TextData, TextStyle> {
  const TextDataEncoder(this.colors);

  final List<Color> colors;

  @override
  Lerp<TextStyle> get lerp => (a, b, t) => TextStyle.lerp(a, b, t)!;

  @override
  Stringify<TextStyle> get stringify => (v) => v.toString();

  @override
  TransformData<TextData, TextStyle>? get transformData =>
      (v, i) => v.toTextStyle(colors[i]);
}

const textDataEncoderBlackWhite = TextDataEncoder([Colors.black, Colors.white]);

@Tailor([
  TailorProp('h3', [TextData.h3, TextData(defaultColor: AppColors.orange)],
      encoder: TextDataEncoder([AppColors.orange, AppColors.blue])),
  TailorProp('h3', [TextData.h3, TextData(defaultColor: AppColors.orange)],
      encoder: textDataEncoderBlackWhite),
  TailorProp<int, double>('luckyNumber', [7, 8], encoder: NumerEncoder()),
], [])
class _$CustomThemeExtensionLightDark2 {}
