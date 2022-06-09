class StringUtil {
  const StringUtil();

  String formatClassName(String value) {
    return value.replaceFirst(r'_$', '').replaceFirst(r'$_', '');
  }
}
