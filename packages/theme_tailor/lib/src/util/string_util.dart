class StringUtil {
  const StringUtil();

  static final _listExpression = RegExp(r'List<(\w+[?]?)>');
  static final _fieldExpression = RegExp(r'(\w+[?]?)\s*?=\s*?[\w+ | \[]');
  static final _staticExpression = RegExp(r'static');

  String formatClassName(String value) {
    return value.replaceFirst(r'_$', '').replaceFirst(r'$_', '');
  }

  bool isStatic(String value) {
    return _staticExpression.hasMatch(value);
  }

  bool isListType(String value) {
    return _listExpression.hasMatch(value);
  }

  bool isField(String value) {
    return _fieldExpression.hasMatch(value);
  }

  String? getFieldName(String value) {
    return _fieldExpression.firstMatch(value)?[1];
  }

  String? getTypeFromList(String value) {
    return _listExpression.firstMatch(value.toString())?[1];
  }
}
