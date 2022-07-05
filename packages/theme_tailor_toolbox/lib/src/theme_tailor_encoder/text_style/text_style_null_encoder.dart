import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/no_lerp_encoder.dart';

const textStyleNullEncoder = TextStyleNullEncoder();
const textStyleNullEncoderNoLerp = TextStyleNullEncoderNoLerp();

class TextStyleNullEncoder extends ThemeEncoder<TextStyle?> {
  const TextStyleNullEncoder();

  @override
  TextStyle? lerp(TextStyle? a, TextStyle? b, double t) {
    return TextStyle.lerp(a, b, t);
  }
}

class TextStyleNullEncoderNoLerp extends NoLerpEncoder<TextStyle?> {
  const TextStyleNullEncoderNoLerp();
}
