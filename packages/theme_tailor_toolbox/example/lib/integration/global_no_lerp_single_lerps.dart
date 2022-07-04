import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

part 'global_no_lerp_single_lerps.tailor.dart';

@tailor
@colorNoLerpEncoder
@materialColorNoLerpEncoder
@materialAccentColorNoLerpEncoder
class _$ExampleAnnotations {
  @colorEncoder
  static const List<Color> color = [Colors.black, Colors.white];
  static const List<Color> colorNoLerp = [Colors.black, Colors.white];

  @materialColorEncoder
  static const List<MaterialColor> materialColor = [
    Colors.amber,
    Colors.pink,
  ];
  static const List<MaterialColor> materialColorNoLerp = [
    Colors.amber,
    Colors.pink,
  ];
  @materialAccentColorEncoder
  static const List<MaterialAccentColor> materialAccentColor = [
    Colors.amberAccent,
    Colors.pinkAccent,
  ];
  static const List<MaterialAccentColor> materialAccentColorNoLerp = [
    Colors.amberAccent,
    Colors.pinkAccent,
  ];
}
