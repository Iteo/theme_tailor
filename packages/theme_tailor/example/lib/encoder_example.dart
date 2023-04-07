import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'encoder_example.tailor.dart';

class TextStyleEncoder extends ThemeEncoder<TextStyle> {
  const TextStyleEncoder();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) =>
      TextStyle.lerp(a, b, t)!;
}

class TextStyleNullableEncoder extends ThemeEncoder<TextStyle?> {
  const TextStyleNullableEncoder();

  @override
  TextStyle? lerp(TextStyle? a, TextStyle? b, double t) =>
      TextStyle.lerp(a, b, t);
}

class CustomColorEncoder extends ThemeEncoder<Color> {
  const CustomColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}

/// Use @Tailor annotation to declare custom themes or different
/// quantity of themes than the default 2 (light and dark)
@Tailor(themes: ['superLight', 'amoledDark'])
class $_Theme1 {
  @CustomColorEncoder()
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  @TextStyleEncoder()
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];

  @TextStyleNullableEncoder()
  static List<TextStyle?> h2 = const [TextStyle(), TextStyle()];
}

const customColorEncoder = CustomColorEncoder();
const textStyleEncoder = TextStyleEncoder();
const textStyleNullableEncoder = TextStyleNullableEncoder();

@Tailor(themes: ['superLight', 'amoledDark'])
class $_Theme2 {
  @customColorEncoder
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  @textStyleEncoder
  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];

  @textStyleNullableEncoder
  static List<TextStyle?> h2 = const [TextStyle(), TextStyle()];
}

@Tailor(
  themes: ['superLight', 'amoledDark'],
  encoders: [
    CustomColorEncoder(),
    TextStyleEncoder(),
    TextStyleNullableEncoder(),
  ],
)
class $_Theme3 {
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle?> h2 = const [TextStyle(), TextStyle()];
}

const tailorWithEncoders = Tailor(
  themes: ['superLight', 'amoledDark'],
  encoders: [customColorEncoder, textStyleEncoder, textStyleNullableEncoder],
);

@tailorWithEncoders
class $_Theme4 {
  static List<Color> background = [AppColors.white, AppColors.black];
  static List<Color> iconColor = [AppColors.orange, AppColors.blue];

  static List<TextStyle> h1 = const [TextStyle(), TextStyle()];
  static List<TextStyle?> h2 = const [TextStyle(), TextStyle()];
}
