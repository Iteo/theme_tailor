import 'dart:collection';

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class ThemeClassConfig {
  const ThemeClassConfig({
    required this.fields,
    required this.returnType,
    required this.baseClassName,
    required this.themes,
    required this.themeGetter,
  });

  final Map<String, String> fields;
  final SplayTreeSet<String> themes;
  final String baseClassName;
  final String returnType;
  final ThemeGetter themeGetter;
}
