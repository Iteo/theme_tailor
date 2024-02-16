// ignore_for_file: deprecated_member_use

import 'package:build/build.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/tailor_annotations_generator.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// Function used by the build runner
Builder themeTailorBuilder(BuilderOptions options) {
  return PartBuilder(
    [TailorAnnotationsGenerator(TailorMixin.fromJson(options.config))],
    '.tailor.dart',
    header: '''
    // coverage:ignore-file
    // GENERATED CODE - DO NOT MODIFY BY HAND
    // ignore_for_file: type=lint, unused_element, unnecessary_cast
    ''',
    options: options,
  );
}
