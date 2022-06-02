String? findGetterName(String value) {
  final expression = RegExp(r'get (\w+)');
  return expression.firstMatch(value)?[1];
}
