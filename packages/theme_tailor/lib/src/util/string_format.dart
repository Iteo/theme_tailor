class StringFormat {
  const StringFormat();

  static const String dynamic = 'dynamic';
  static const String nullSuffix = '?';

  String themeClassName(String val, [String suffix = 'Theme']) {
    final name = val.replaceFirst(r'_$', '').replaceFirst(r'$_', '');
    if (name.isNotEmpty) val.firstToUpper();
    return name != val ? name : '$name$suffix';
  }

  String asCammelCase(String val) {
    return val.isEmpty ? val : val.firstToLower();
  }

  String asPrivate(String val) {
    return val.isEmpty ? val : '_$val';
  }

  String asNullableType(String val) {
    if (val == dynamic) return dynamic;
    if (val.endsWith(nullSuffix)) return val;
    return '$val?';
  }

  String typeAsVariableName(String val, [String suffix = '_']) {
    final name = asCammelCase(val);
    print(name);
    return val != name ? name : '$name$suffix';
  }
}

extension StringExtension on String {
  String firstToUpper() => '${this[0].toUpperCase()}${substring(1)}';
  String firstToLower() => '${this[0].toLowerCase()}${substring(1)}';
}
