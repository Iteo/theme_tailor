import 'package:test/test.dart';
import 'package:theme_tailor/src/util/extensions.dart';

void main() {
  group('ScopeExtensions', () {
    test('let', () {
      const test = 'let';
      expect(test.let((it) => '$it it go'), 'let it go');
      expect(test.let((it) => it.length), 3);
    });

    test('also', () {
      const test = 'also';
      expect(test.also((it) => '$it.ok'), 'also.ok');
    });
  });
}
