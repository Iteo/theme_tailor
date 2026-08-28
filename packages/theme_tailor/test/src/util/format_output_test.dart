import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:theme_tailor/src/util/format_output.dart';

void main() {
  final languageVersion = Version(3, 13, 2);

  group('formatTailorGeneratedOutput', () {
    test('prepends a format-off directive when formatting is disabled', () {
      const source = 'final  x=1;';

      expect(
        formatTailorGeneratedOutput(
          source,
          languageVersion: languageVersion,
          format: false,
        ),
        '$tailorFormatOffDirective\n$source',
      );
    });

    test('formats source without prepending a format-off directive', () {
      const source = 'final  x=1;';

      final result = formatTailorGeneratedOutput(
        source,
        languageVersion: languageVersion,
      );

      expect(
        result,
        DartFormatter(languageVersion: languageVersion).format(source),
      );
      expect(result, isNot(startsWith('$tailorFormatOffDirective\n')));
    });

    test('formats output normally when no formatting option is supplied', () {
      const source = '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'example.dart';

class Example {
  final int veryLongFieldNameThatWouldWrapDifferentlyAtDifferentPageWidths;
}
''';

      final result = formatTailorGeneratedOutput(
        source,
        languageVersion: languageVersion,
      );

      expect(
        result,
        DartFormatter(languageVersion: languageVersion).format(source),
      );
      expect(result, isNot(startsWith('$tailorFormatOffDirective\n')));
    });
  });
}
