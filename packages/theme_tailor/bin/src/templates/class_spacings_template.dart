import 'package:theme_tailor/presentation/style/app_colors.dart';
import 'package:theme_tailor/presentation/style/spacings.dart';

import '../models/spacing.dart';

var _spacings = <Spacing>[
  Spacing(value: 0.0, name: "zero"),
  Spacing(value: 2.0, name: "xxxsm"),
  Spacing(value: 4.0, name: "xxsm"),
  Spacing(value: 8.0, name: "xsm"),
  Spacing(value: 12.0, name: "sm"),
  Spacing(value: 16.0, name: "md"),
  Spacing(value: 20.0, name: "big"),
  Spacing(value: 24.0, name: "xbig"),
  Spacing(value: 28.0, name: "xxbig"),
  Spacing(value: 32.0, name: "xxxbig"),
  Spacing(value: 40.0, name: "lg"),
  Spacing(value: 48.0, name: "xlg"),
  Spacing(value: 64.0, name: "xxlg"),
  Spacing(value: 80.0, name: "xxxlg"),
  Spacing(value: 96.0, name: "huge"),
  Spacing(value: 128.0, name: "xhuge"),
  Spacing(value: 160.0, name: "xxhuge"),
  Spacing(value: 192.0, name: "xxxhuge"),
];

class ClassSpacingsTemplate {
  String generate() {
    return '''
${_classGenerate()}
''';
  }

  String _classGenerate() {
    return '''
class Spacings {
const Spacings._();

${_generateSpacingsMaps()}

${_generateSpacings()}
''';
  }

  String _generateSpacings() {
    final buffer = StringBuffer();

    for (final spacing in _spacings) {
      buffer.writeln('\n /// ${spacing.name}');

      buffer.writeln('static const ${spacing.name} = ${spacing.value};');
    }

    return buffer.toString();
  }

  String _generateSpacingsMaps() {
    final buffer = StringBuffer();

    buffer.writeln('\nstatic Map<String, double> get allSpacing => {');

    for (final spacing in _spacings) {
      buffer.writeln('"${spacing.name}": ${spacing.value},');
    }

    buffer.writeln("};");

    return buffer.toString();
  }
}
