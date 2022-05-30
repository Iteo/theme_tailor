// ignore_for_file: constant_identifier_names

import 'package:analyzer/dart/ast/ast.dart';
import 'package:analyzer/dart/element/type.dart';

import '../util/type_util.dart';

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
  ThemeExtensionField(
    this.name,
    this.values,
    this.valuesType,
    this.encoder,
    this.encoderType,
  ) : type = TypeUtil.typeFromDartTypeCollection(valuesType);

  final String name;
  final Iterable<CollectionElement> values;
  final Iterable<DartType?> valuesType;
  final Expression? encoder;
  final DartType? encoderType;
  late final String type;
}
