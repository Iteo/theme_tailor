// ignore_for_file: unused_field, unused_element

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

part 'global_no_lerp_single_lerps.tailor.dart';

@TailorComponent(themes: [])
@colorNoLerpEncoder
@materialColorNoLerpEncoder
@materialAccentColorNoLerpEncoder
class _$Theme {
  @colorEncoder
  static const List<Color> color = [];
  static const List<Color> colorNoLerp = [];

  @materialColorEncoder
  static const List<MaterialColor> materialColor = [];
  static const List<MaterialColor> materialColorNoLerp = [];
  @materialAccentColorEncoder
  static const List<MaterialAccentColor> materialAccentColor = [];
  static const List<MaterialAccentColor> materialAccentColorNoLerp = [];
}
