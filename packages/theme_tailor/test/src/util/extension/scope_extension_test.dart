import 'package:test/test.dart';
import 'package:theme_tailor/src/util/extension/scope_extension.dart';

void main() {
  group('ScopeExtension', () {
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
