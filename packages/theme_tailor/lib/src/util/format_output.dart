import 'package:dart_style/dart_style.dart';
import 'package:pub_semver/pub_semver.dart';

const tailorFormatOffDirective = '// dart format off';

/// Formats generated tailor output and prepends a format-off directive so
/// project-wide `dart format` runs do not reformat `.tailor.dart` files.
String formatTailorGeneratedOutput(
  String source, {
  required Version languageVersion,
  bool format = true,
}) {
  if (!format) return source;

  final formatted = DartFormatter(languageVersion: languageVersion).format(source);
  return '$tailorFormatOffDirective\n$formatted';
}
