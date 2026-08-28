import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';

const tailorFormatOffDirective = '// dart format off';

/// Formats generated tailor output.
///
/// When formatting is disabled, prepends a format-off directive so
/// project-wide `dart format` runs do not reformat the raw `.tailor.dart`
/// output.
String formatTailorGeneratedOutput(
  String source, {
  required Version languageVersion,
  bool format = true,
}) {
  if (!format) return '$tailorFormatOffDirective\n$source';

  return DartFormatter(languageVersion: languageVersion).format(source);
}
