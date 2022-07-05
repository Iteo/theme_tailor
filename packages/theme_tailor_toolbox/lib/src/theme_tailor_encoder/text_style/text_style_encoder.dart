import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/no_lerp_encoder.dart';

const textStyleEncoder = TextStyleEncoder();
const textStyleEncoderNoLerp = TextStyleEncoderNoLerp();

class TextStyleEncoder extends ThemeEncoder<TextStyle> {
  const TextStyleEncoder();

  @override
  TextStyle lerp(TextStyle a, TextStyle b, double t) {
    return TextStyle.lerp(a, b, t)!;
  }
}

class TextStyleEncoderNoLerp extends NoLerpEncoder<TextStyle> {
  const TextStyleEncoderNoLerp();
}

class TextStyleNullEncoderImpl extends ThemeEncoder<TextStyle?> {
  const TextStyleNullEncoderImpl();

  @override
  TextStyle? lerp(TextStyle? a, TextStyle? b, double t) {
    return TextStyle.lerp(a, b, t);
  }
}

class TextStyleNullNoLerpEncoderImpl extends NoLerpEncoder<TextStyle?> {
  const TextStyleNullNoLerpEncoderImpl();
}
