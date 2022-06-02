import 'dart:collection';

import 'package:analyzer/dart/ast/ast.dart';

class ThemeExtensionClassConfig {
  const ThemeExtensionClassConfig({
    required this.expressions,
    required this.fields,
    required this.returnType,
    required this.themes,
  });

  final SplayTreeMap<String, String> fields;
  final SplayTreeMap<String, Expression> expressions;
  final SplayTreeSet<String> themes;
  final String returnType;
}
