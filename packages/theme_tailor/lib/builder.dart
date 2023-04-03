import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/theme_tailor_generator.dart';
import 'package:theme_tailor/src/model/tailor_defaults.dart';

/// Function used by the build runner
Builder themeTailorBuilder(BuilderOptions options) {
  return PartBuilder(
    [
      TailorGenerator(
        builderOptions: options,
        buildYamlConfig: TailorAnnotationData.fromJson(options.config),
      )
    ],
    '.tailor.dart',
    header: '''
    // coverage:ignore-file
    // GENERATED CODE - DO NOT MODIFY BY HAND
    // ignore_for_file: type=lint, unused_element
    ''',
    options: options,
  );
}
