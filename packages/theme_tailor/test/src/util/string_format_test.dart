import 'package:test/test.dart';
import 'package:theme_tailor/src/util/string_format.dart';

void main() {
  late StringFormat stringFormat;

  setUpAll(() {
    stringFormat = const StringFormat();
  });

  group('StringFormat', () {
    test('themeClassName', () {
      String fun(String val) => stringFormat.themeClassName(val);

      var test = r'_$';
      expect(fun(test), 'CustomTheme');

      test = r'$_';
      expect(fun(test), 'CustomTheme');

      test = r'$_TestClass2';
      expect(fun(test), 'TestClass2');

      test = r'$';
      expect(fun(test), r'$CustomTheme');

      test = r'$$';
      expect(fun(test), r'$$CustomTheme');
    });

    test('asCammelCase', () {
      String fun(String val) => stringFormat.asCammelCase(val);

      var test = '';
      expect(fun(test), '');

      test = r'$';
      expect(fun(test), r'$');

      test = r'$_';
      expect(fun(test), r'$_');

      test = r'_$';
      expect(fun(test), r'_$');

      test = 'test';
      expect(fun(test), 'test');

      test = 'Test';
      expect(fun(test), 'test');
    });

    test('asPrivate', () {
      String fun(String val) => stringFormat.asPrivate(val);

      var test = '';
      expect(fun(test), '_');

      test = r'$';
      expect(fun(test), r'_$');

      test = r'$_';
      expect(fun(test), r'_$_');

      test = r'_$';
      expect(fun(test), r'__$');

      test = 'test';
      expect(fun(test), '_test');

      test = 'Test';
      expect(fun(test), '_Test');
    });

    test('asNullableType', () {
      String fun(String val) => stringFormat.asNullableType(val);
      var test = 'dynamic';
      expect(fun(test), 'dynamic');

      test = '';
      expect(fun(test), '?');

      test = 'Object';
      expect(fun(test), 'Object?');

      test = 'int';
      expect(fun(test), 'int?');

      test = 'Color';
      expect(fun(test), 'Color?');
    });

    test('typeAsVariableName', () {
      // ignore: avoid_redundant_argument_values
      String fun(String val) => stringFormat.typeAsVariableName(val, '_');

      var test = 'dynamic';
      expect(fun(test), 'dynamic_');

      test = '';
      expect(fun(test), '_');
      expect(stringFormat.typeAsVariableName(test, 'a'), 'a');

      test = 'Object';
      expect(fun(test), 'object');

      test = 'int';
      expect(fun(test), 'int_');

      test = 'CustomTheme';
      expect(fun(test), 'customTheme');

      test = r'$CustomTheme';
      expect(fun(test), r'$CustomTheme_');

      test = r'_$CustomTheme';
      expect(fun(test), r'_$CustomTheme_');
    });
  });
}
