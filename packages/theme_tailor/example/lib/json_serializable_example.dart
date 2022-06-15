import 'dart:ui';

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

@tailor
@JsonSerializable()
class _$SerializableTE {
  static List<int> foo = [10, 20];

  @JsonColorConverter()
  @JsonKey(name: 'bar')
  @CustomColorEncoder()
  static List<Color> bar = [Colors.orange, Colors.pink];
}

@JsonSerializable()
class JsonSerializableTE extends ThemeExtension<JsonSerializableTE> {
  const JsonSerializableTE({
    required this.foo,
    required this.bar,
  });

  factory JsonSerializableTE.fromJson(Map<String, dynamic> json) =>
      _$JsonSerializableTEFromJson(json);

  final int foo;

  @JsonColorConverter()
  final Color bar;

  static final JsonSerializableTE superLight =
      const JsonSerializableTE(foo: 10, bar: Colors.orange);

  static final JsonSerializableTE amoledDark =
      const JsonSerializableTE(foo: 20, bar: Colors.pink);

  static final List<JsonSerializableTE> themes = [superLight, amoledDark];

  @override
  JsonSerializableTE copyWith({
    int? foo,
    Color? bar,
  }) {
    return JsonSerializableTE(
      foo: foo ?? this.foo,
      bar: bar ?? this.bar,
    );
  }

  @override
  JsonSerializableTE lerp(ThemeExtension<JsonSerializableTE>? other, double t) {
    if (other is! JsonSerializableTE) return this;
    return JsonSerializableTE(
      foo: lerpDouble(foo, other.foo, t)!.toInt(),
      bar: Color.lerp(bar, other.bar, t)!,
    );
  }
}
