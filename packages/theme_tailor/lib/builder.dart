// ignore_for_file: deprecated_member_use

import 'package:build/build.dart';
import 'package:dart_style/dart_style.dart';
import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor/src/generator/tailor_annotations_generator.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// Function used by the build runner
Builder themeTailorBuilder(BuilderOptions options) {
  final format = options.config['format'] != false;
  return PartBuilder(
    [TailorAnnotationsGenerator(TailorMixin.fromJson(options.config))],
    formatOutput: (str, version) {
      if (format) return str;

      return DartFormatter(languageVersion: version).format(str);
    },
    '.tailor.dart',
    header: '''
// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark
''' + (format ? '' : '// dart format off\n'),
    options: options,
  );
}
