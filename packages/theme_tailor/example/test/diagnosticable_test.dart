import 'dart:math';

import 'package:example/diagnosticable.dart' as diagnosticable;
import 'package:example/diagnosticable_barrel_import.dart'
    as diagnosticable_barrel;
import 'package:example/diagnosticable_lib.dart';
import 'package:example/empty_theme.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('has debugFillProperties if importing flutter#foundation', () {
    final properties = DiagnosticPropertiesBuilder();

    final randomColor = Colors.accents[Random().nextInt(Colors.accents.length)];
    final textStyle = TextStyle(color: randomColor);

    final theme = diagnosticable.MyTheme(
      background: randomColor,
      textStyle: textStyle,
    )..debugFillProperties(properties);

    expect(theme, isA<DiagnosticableTree>());

    expect(properties.properties, [
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'type')
          .having((d) => d.value, 'value', 'MyTheme'),
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'background')
          .having((d) => d.value, 'value', randomColor),
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'textStyle')
          .having((d) => d.value, 'value', textStyle),
    ]);
  });

  test('has debugFillProperties if importing flutter#foundation from barrel',
      () {
    final properties = DiagnosticPropertiesBuilder();

    final randomColor = Colors.accents[Random().nextInt(Colors.accents.length)];
    final textStyle = TextStyle(color: randomColor);

    final theme = diagnosticable_barrel.MyTheme(
      background: randomColor,
      textStyle: textStyle,
    )..debugFillProperties(properties);

    expect(theme, isA<DiagnosticableTree>());

    expect(properties.properties, [
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'type')
          .having((d) => d.value, 'value', 'MyTheme'),
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'background')
          .having((d) => d.value, 'value', randomColor),
      isA<DiagnosticsProperty>()
          .having((d) => d.name, 'name', 'textStyle')
          .having((d) => d.value, 'value', textStyle),
    ]);
  });

  test('no debugFillProperties if not importing flutter#foundation', () {
    const theme = EmptyTheme();

    expect(theme, isNot(isA<DiagnosticableTree>()));
  });
}
