import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'equals_hash_code.tailor.dart';

typedef TProp<T> = List<T>;

@tailor
class _$GreetingsTheme {
  static const TProp<List<String>> greetings = [
    ['Let there be light', 'Praise the sun'],
    ['Good night'],
  ];
}
