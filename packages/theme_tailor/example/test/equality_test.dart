import 'package:example/extensions_getters_example.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Equal and hash code overrides', () {
    final theme1 = ExtensionGettersExample1(Colors.white);
    final theme2 = ExtensionGettersExample1(Colors.white);
    expect(theme1 == theme2, true);
    expect(theme1.hashCode == theme2.hashCode, true);
  });
}
