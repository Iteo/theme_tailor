import 'dart:collection';

import 'package:analyzer/dart/constant/value.dart';
import 'package:analyzer/dart/element/type.dart';

class ThemeExtensionClassConfig {
  const ThemeExtensionClassConfig({
    required this.fields,
    required this.returnType,
    required this.baseClassName,
    required this.themes,
    this.encoders = const [],
  });

  final SplayTreeMap<String, DartType> fields;
  final SplayTreeSet<String> themes;
  final String baseClassName;
  final String returnType;
  final List<DartObject> encoders;
}
