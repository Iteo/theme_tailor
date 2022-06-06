class ThemeEncoderData {
  ThemeEncoderData.className(
    String className,
    String accessor,
    this.type,
  ) : accessString = 'const $className${_withAccessor(accessor)}()';

  ThemeEncoderData.propertyAccess(
    this.accessString,
    this.type,
  );

  static String _withAccessor(String accessor) => accessor.isEmpty ? '' : '.$accessor';

  final String accessString;
  final String type;

  @override
  String toString() {
    return 'accesStr: $accessString, type: $type';
  }
}
