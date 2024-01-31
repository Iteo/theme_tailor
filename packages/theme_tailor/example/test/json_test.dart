import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:example/json_serializable_example.dart';
import 'package:flutter_test/flutter_test.dart';

import 'random_values.dart';

void main() {
  test('Serializable theme <- from JSON', () {
    final barColor = randomColor();
    final fooNumber = randomInt();

    final themeStr = '{"bar_color":${barColor.value},"foo_number":$fooNumber}';

    final json = jsonDecode(themeStr) as Map<String, dynamic>;

    final serializableTheme = SerializableTheme.fromJson(json);

    expect(serializableTheme.barColor, barColor);
    expect(serializableTheme.fooNumber, fooNumber);
  });

  test('Serializable theme -> to JSON', () {
    final barColor = randomColor();
    final fooNumber = randomInt();

    final theme = SerializableTheme(
      barColor: barColor,
      fooNumber: fooNumber,
    );

    final themeMap = theme.toJson();

    final expectedThemeMap = {
      'bar_color': barColor.value,
      'foo_number': fooNumber,
    };

    expect(
      const DeepCollectionEquality().equals(themeMap, expectedThemeMap),
      true,
    );
  });
}
