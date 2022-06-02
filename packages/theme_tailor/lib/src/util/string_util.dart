class StringUtil {
  const StringUtil();

  static final _listExpression = RegExp(r'List<(\w+[?]?)>');
  static final _getterExpression = RegExp(r'get (\w+[?]?)');

  String formatClassName(String value) {
    return value.replaceFirst(r'_$', '').replaceFirst(r'$_', '');
  }

  bool isListType(String value) {
    return _listExpression.hasMatch(value);
  }

  bool isGetter(String value) {
    return _getterExpression.hasMatch(value);
  }

  String? getGetterName(String value) {
    return _getterExpression.firstMatch(value)?[1];
  }

  String? getTypeFromList(String value) {
    return _listExpression.firstMatch(value.toString())?[1];
  }
}
