import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/color_encoder.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/material_accent_color_encoder.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/material_color_encoder.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/no_lerp_encoder.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/text_style_encoder.dart';

/// ### EncoderToolbox
/// Collections of the nullable and non-nullable ThemeEncoders for ThemeTailor code generator.\
/// Each of the types has 2 variants of encoders. Lerping and Non-lerping encoders named as following: \
/// Non-nullable types:
/// * fooLerp
/// * fooNoLerp
///
/// Nullable types:
/// * fooNullableLerp
/// * fooNullableNoLerp
abstract class EncoderToolbox {
  /// Interpolating encoder for `Color`
  static const colorLerp = ColorEncoder();

  /// Non-interpolating encoder for `Color`
  static const colorNoLerp = NoLerpEncoder<Color>();

  /// Interpolating encoder for `Color?`
  static const colorNullableLerp = ColorNullableEncoder();

  /// Non-interpolating encoder for `Color?`
  static const colorNullableNoLerp = NoLerpEncoder<Color?>();

  /// Non-interpolating encoder for `MaterialAccentColor`
  static const materialAccentColorLerp = MaterialAccentColorEncoder();

  /// Non-interpolating encoder for `MaterialAccentColor`
  static const materialAccentColorNoLerp = NoLerpEncoder<MaterialAccentColor>();

  /// Interpolating encoder for `MaterialAccentColor?`
  static const materialAccentColorNullableLerp =
      MaterialAccentColorNullableEncoder();

  /// Non-interpolating encoder for `MaterialAccentColor?`
  static const materialAccentColorNullableNoLerp =
      NoLerpEncoder<MaterialAccentColor?>();

  /// Interpolating encoder for `MaterialColor`
  static const materialColorLerp = MaterialColorEncoder();

  /// Non-interpolating encoder for `MaterialColor`
  static const materialColorNoLerp = NoLerpEncoder<MaterialColor>();

  /// Interpolating encoder for `MaterialColor?`
  static const materialColorNullableLerp = MaterialColorNullableEncoder();

  /// Non-interpolating encoder for `MaterialColor?`
  static const materialColorNullableNoLerp = NoLerpEncoder<MaterialColor?>();

  /// Interpolating encoder for `TextStyle`
  static const textStyleLerp = TextStyleEncoder();

  /// Non-interpolating encoder for `TextStyle`
  static const textStyleNoLerp = NoLerpEncoder<TextStyle>();

  /// Interpolating encoder for `TextStyle?`
  static const textStyleNullableLerp = TextStyleNullableEncoder();

  /// Non-interpolating encoder for `TextStyle?`
  static const textStyleNullableNoLerp = NoLerpEncoder<TextStyle?>();
}
