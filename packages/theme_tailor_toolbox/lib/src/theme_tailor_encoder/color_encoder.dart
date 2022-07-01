import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/util/lerp_color.dart';

class ColorEncoder extends ThemeEncoder<Color> {
  const ColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => lerpColor(a, b, t);
}

class ColorNullEncoder extends ThemeEncoder<Color?> {
  @override
  Color? lerp(Color? a, Color? b, double t) => Color.lerp(a, b, t);
}

class ColorJsonConverter extends JsonConverter<Color, int> {
  @override
  Color fromJson(json) => Color(json);

  @override
  int toJson(object) => object.value;
}

class ColorNullJsonConverter extends JsonConverter<Color?, int?> {
  @override
  Color? fromJson(json) => json == null ? null : Color(json);

  @override
  int? toJson(object) => object?.value;
}
