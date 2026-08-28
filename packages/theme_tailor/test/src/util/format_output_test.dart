import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';
import 'package:test/test.dart';
import 'package:theme_tailor/src/util/format_output.dart';

void main() {
  final languageVersion = Version(3, 9, 0);

  group('formatTailorGeneratedOutput', () {
    test('returns source unchanged when format is disabled', () {
      const source = 'final  x=1;';

      expect(
        formatTailorGeneratedOutput(
          source,
          languageVersion: languageVersion,
          format: false,
        ),
        source,
      );
    });

    test('formats source and prepends dart format off directive', () {
      const source = 'final  x=1;';

      final result = formatTailorGeneratedOutput(
        source,
        languageVersion: languageVersion,
      );

      expect(result, startsWith('$tailorFormatOffDirective\n'));
      expect(
        result.substring(tailorFormatOffDirective.length + 1),
        DartFormatter(languageVersion: languageVersion).format(source),
      );
    });

    test('preserves formatted output when re-formatted with format off at top', () {
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

      expect(result, startsWith('$tailorFormatOffDirective\n'));

      final withoutDirective = result.substring(tailorFormatOffDirective.length + 1);
      expect(
        DartFormatter(languageVersion: languageVersion).format(withoutDirective),
        withoutDirective,
      );
    });
  });
}
