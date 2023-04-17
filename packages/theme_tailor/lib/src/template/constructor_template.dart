import 'package:theme_tailor/src/model/constructor_parameters.dart';
import 'package:theme_tailor/src/template/template.dart';

class ConstructorTemplate extends Template {
  ConstructorTemplate({
    required this.constructorName,
    required this.fieldNameToValue,
    this.fieldNameToParamType,
  });

  final String constructorName;
  final Map<String, CtorParamType>? fieldNameToParamType;
  final Iterable<MapEntry<String, String>> fieldNameToValue;

  @override
  void write(StringBuffer buffer) {
    if (fieldNameToParamType == null) return writeAllAsNamedParams(buffer);

    final inRequired = <String>{};
    final inNamed = <String>{};
    final inOptional = <String>{};

    for (final field in fieldNameToValue) {
      fieldNameToParamType![field.key]?.when(
        () => inRequired.add('${field.value},'),
        () => inNamed.add('${field.key}: ${field.value},'),
        () => inOptional.add('${field.value},'),
      );
    }

    buffer
      ..writeln(constructorName)
      ..write('(')
      ..writeAll(inRequired)
      ..writeAll(inNamed.isNotEmpty ? inNamed : inOptional)
      ..write(')');
  }

  void writeAllAsNamedParams(StringBuffer buffer) {
    buffer
      ..writeln(constructorName)
      ..write('(')
      ..writeAll(fieldNameToValue.map((e) => '${e.key}: ${e.value},'))
      ..writeln(')');
  }
}
