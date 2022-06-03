import 'dart:collection';

class ThemeExtensionClassConfig {
  const ThemeExtensionClassConfig({
    required this.fields,
    required this.returnType,
    required this.baseClassName,
    required this.themes,
  });

  final SplayTreeMap<String, String> fields;
  final SplayTreeSet<String> themes;
  final String baseClassName;
  final String returnType;
}
