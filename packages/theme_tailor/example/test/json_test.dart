import 'dart:convert';

import 'package:example/json_serializable_example.dart';
import 'package:flutter_test/flutter_test.dart';

import 'random_values.dart';

void main() {
  test('Serializable theme <- from JSON', () {
    final barColor = randomColor();
    final fooNumber = randomInt();

    final themeStr =
        '''{"bar_color":${barColor.value},"foo_number":$fooNumber}''';

    final json = jsonDecode(themeStr) as Map<String, dynamic>;

    final serializableTheme = SerializableTE.fromJson(json);

    expect(serializableTheme.barColor, barColor);
    expect(serializableTheme.fooNumber, fooNumber);
  });
}
