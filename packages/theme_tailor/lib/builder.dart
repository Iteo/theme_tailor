import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';

import 'package:theme_tailor/src/generator/theme_tailor_generator.dart';

Builder themeTailorBuilder(BuilderOptions options) {
  return PartBuilder(
    [ThemeTailorGenerator()],
    '.tailor.dart',
    header: '''
    // coverage:ignore-file
    // GENERATED CODE - DO NOT MODIFY BY HAND
    // ignore_for_file: type=lint
    ''',
    options: options,
  );
}
