// ignore_for_file: unused_field, unused_element

import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

part 'global_no_lerp_single_lerps.tailor.dart';

@TailorComponent(themes: ['light'])
@NoLerpEncoder<Color>()
@NoLerpEncoder<MaterialColor>()
@NoLerpEncoder<MaterialAccentColor>()
@NoLerpEncoder<TextStyle>()
class _$CustomTheme {
  @EncoderToolbox.colorLerp
  static const List<Color> color = [];
  static const List<Color> colorNoLerp = [];

  @EncoderToolbox.materialColorLerp
  static const List<MaterialColor> materialColor = [];
  static const List<MaterialColor> materialColorNoLerp = [];

  @EncoderToolbox.materialAccentColorLerp
  static const List<MaterialAccentColor> materialAccentColor = [];
  static const List<MaterialAccentColor> materialAccentColorNoLerp = [];
}
