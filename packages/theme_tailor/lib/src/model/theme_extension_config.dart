import '../template/constructor_template.dart';

class ThemeExtensionConfig {
  const ThemeExtensionConfig(
    this.className,
    this.themeNames,
    this.fields,
  );

  factory ThemeExtensionConfig.fromData(
    String className,
    Iterable<String> themeNames,
    List<ThemeExtensionField> fields,
  ) {
    return ThemeExtensionConfig(className, themeNames, fields);
  }

  final String className;
  final Iterable<String> themeNames;
  final Iterable<ThemeExtensionField> fields;
}

class ThemeExtensionField {
  ThemeExtensionField(this.name, this.values);

  final String name;
  final Iterable<ValueModel> values;
}
