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

@Tailor(generateStaticGetters: false)
@JsonSerializable(explicitToJson: true)
@CustomColorEncoder()
@JsonColorConverter()
class _$SerializableTheme {
  @JsonKey(name: 'foo_number')
  static List<int> fooNumber = [10, 20];

  @JsonKey(name: 'bar_color')
  static List<Color> barColor = [Colors.orange, Colors.pink];

  @themeExtension
  static List<NestedSerializableTheme> nested = NestedSerializableTheme.themes;
}

extension SerializableThemeExt on SerializableTheme {
  Map<String, dynamic> toJson() => _$SerializableThemeToJson(this);
}

@tailorComponent
@JsonSerializable()
@JsonColorConverter()
@CustomColorEncoder()
class _$NestedSerializableTheme {
  static List<Color> nestedBar = [Colors.orange, Colors.pink];
}

extension NestedSerializableThemeExt on NestedSerializableTheme {
  Map<String, dynamic> toJson() => _$NestedSerializableThemeToJson(this);
}
