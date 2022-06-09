class StringFormat {
  const StringFormat();

  static const String dynamic = 'dynamic';
  static const String nullSuffix = '?';

  String themeClassName(String val, [String suffix = 'CustomTheme']) {
    if (val.isEmpty) return suffix;

    final shouldTrimFirst = val[0] == '_' || val[0] == r'$';
    if (val.length == 1 && shouldTrimFirst) return suffix;

    final name = (shouldTrimFirst ? val.trimFirst() : val).firstToUpperUnsafe();
    return name != val ? name : '$name$suffix';
  }

  String asCammelCase(String val) => val.firstToLower();

  String asPrivate(String val) => '_$val';

  String asNullableType(String val) {
    if (val == dynamic) return dynamic;
    if (val.endsWith(nullSuffix)) return val;
    return '$val?';
  }

  String typeAsVariableName(String val, [String suffix = '_']) {
    final name = asCammelCase(val);
    return val != name ? name : '$name$suffix';
  }
}

extension StringExtension on String {
  String trimFirst() => isEmpty ? this : substring(1);

  String firstToUpper() => _safeSubstring(toUpper: true);
  String firstToLower() => _safeSubstring(toUpper: false);

  String firstToUpperUnsafe() => this[0].toUpperCase() + substring(1);
  String firstToLowerUnsafe() => this[0].toLowerCase() + substring(1);

  String get firstAsUpper => this[0].toUpperCase();
  String get firstAsLower => this[0].toLowerCase();

  bool _canRunSubstring(String val) => val.length > 1;
  String _safeSubstring({required bool toUpper}) {
    late final first = toUpper ? firstAsUpper : firstAsLower;
    if (isEmpty) return this;
    if (!_canRunSubstring(this)) return first;
    return first + substring(1);
  }
}
