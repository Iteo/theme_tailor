// ignore_for_file: annotate_overrides, deprecated_member_use

import 'package:example/encoder_example.dart';
import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'json_serializable_example.tailor.dart';
part 'json_serializable_example.g.dart';

class JsonColorConverter implements JsonConverter<Color, int> {
  const JsonColorConverter();

  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}

@tailorMixin
@JsonSerializable(explicitToJson: true)
@CustomColorEncoder()
@JsonColorConverter()
class SerializableTheme extends ThemeExtension<SerializableTheme> with _$SerializableThemeTailorMixin {
  SerializableTheme({
    required this.fooNumber,
    this.barColor = Colors.black,
  });

  factory SerializableTheme.fromJson(Map<String, dynamic> json) => _$SerializableThemeFromJson(json);

  @JsonKey(name: 'foo_number', defaultValue: 10)
  final int fooNumber;

  @JsonKey(name: 'bar_color')
  final Color barColor;

  Map<String, dynamic> toJson() => _$SerializableThemeToJson(this);
}
