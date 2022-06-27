import 'package:example/equals_hash_code.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Equal and hash code overrides', () {
    const greetings = ['Hello', 'there'];
    final theme1 = GreetingsTheme(greetings: greetings);
    final theme2 = GreetingsTheme(greetings: greetings);
    expect(theme1 == theme2, true);
    expect(theme1.hashCode == theme2.hashCode, true);
  });
}
