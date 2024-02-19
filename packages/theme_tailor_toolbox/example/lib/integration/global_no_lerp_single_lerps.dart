// ignore_for_file: unused_field, unused_element, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

part 'global_no_lerp_single_lerps.tailor.dart';

@TailorMixinComponent()
@NoLerpEncoder<Color>()
@NoLerpEncoder<MaterialColor>()
@NoLerpEncoder<MaterialAccentColor>()
@NoLerpEncoder<TextStyle>()
class CustomTheme extends ThemeExtension<CustomTheme> with _$CustomThemeTailorMixin {
  CustomTheme({
    required this.color,
    required this.colorNoLerp,
    required this.materialColor,
    required this.materialColorNoLerp,
    required this.materialAccentColor,
    required this.materialAccentColorNoLerp,
  });

  @EncoderToolbox.colorLerp
  @override
  final Color color;
  @override
  final Color colorNoLerp;

  @EncoderToolbox.materialColorLerp
  @override
  final MaterialColor materialColor;
  @override
  final MaterialColor materialColorNoLerp;

  @EncoderToolbox.materialAccentColorLerp
  @override
  final MaterialAccentColor materialAccentColor;
  @override
  final MaterialAccentColor materialAccentColorNoLerp;
}
