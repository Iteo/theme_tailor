import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'nullable_params.tailor.dart';

@Tailor()
class _$NullableParams {
  static List<Color?> nullableProperty = [
    Colors.white,
    Colors.blue,
  ];

  static List<Color> anotherProperty = [
    Colors.green,
    Colors.black,
  ];
}

const nullableParams = NullableParams(
  anotherProperty: Colors.green,
);
