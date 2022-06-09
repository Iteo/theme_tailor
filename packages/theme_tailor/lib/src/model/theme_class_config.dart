import 'dart:collection';

import 'package:theme_tailor/src/model/theme_getter_data.dart';

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
  final ThemeGetterData themeGetter;
}
