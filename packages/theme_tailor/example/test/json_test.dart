import 'dart:convert';

import 'package:collection/collection.dart';
import 'package:example/json_serializable_example.dart';
import 'package:flutter_test/flutter_test.dart';

import 'random_values.dart';

void main() {
  test('Serializable theme <- from JSON', () {
    final barColor = randomColor();
    final fooNumber = randomInt();
    final nestedBar = NestedSerializableTheme(nestedBar: randomColor());

    final themeStr =
        '{"bar_color":${barColor.value},"foo_number":$fooNumber,"nested":{"nestedBar":${nestedBar.nestedBar.value}}}';

    final json = jsonDecode(themeStr) as Map<String, dynamic>;

    final serializableTheme = SerializableTheme.fromJson(json);

    expect(serializableTheme.barColor, barColor);
    expect(serializableTheme.fooNumber, fooNumber);
    expect(serializableTheme.nested, nestedBar);
  });

  test('Serializable theme -> to JSON', () {
    final barColor = randomColor();
    final fooNumber = randomInt();
    final nestedBar = NestedSerializableTheme(nestedBar: randomColor());

    final theme = SerializableTheme(
      barColor: barColor,
      fooNumber: fooNumber,
      nested: nestedBar,
    );
    final themeMap = theme.toJson();

    final expectedThemeMap = {
      'bar_color': barColor.value,
      'foo_number': fooNumber,
      'nested': {'nestedBar': nestedBar.nestedBar.value}
    };

    expect(
      const DeepCollectionEquality().equals(themeMap, expectedThemeMap),
      true,
    );
  });
}
