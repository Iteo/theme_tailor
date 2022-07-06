import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// Default implementations of ThemeEncoders for TextStyle and TextStyle?
/// Use TextStyleEncoder() for ThemeEncoder<TextStyle> encoder,
/// Use TextStyleEncoder.nullable() for ThemeEncoder<TextStyle?> encoder,
abstract class TextStyleEncoder {
  const factory TextStyleEncoder() = TextStyleEncoderImpl;
  const factory TextStyleEncoder.nullable() = TextStyleNullableEncoderImpl;
}

/// @nodoc
class TextStyleEncoderImpl extends ThemeEncoder<TextStyle>
    implements TextStyleEncoder {
  const TextStyleEncoderImpl();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) {
    return TextStyle.lerp(a, b, t)!;
  }
}

/// @nodoc
class TextStyleNullableEncoderImpl extends ThemeEncoder<TextStyle?>
    implements TextStyleEncoder {
  const TextStyleNullableEncoderImpl();

  @override
  TextStyle? lerp(TextStyle? a, TextStyle? b, double t) {
    return TextStyle.lerp(a, b, t);
  }
}
