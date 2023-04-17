import 'package:theme_tailor/src/model/constructor_parameters.dart';
import 'package:theme_tailor/src/template/template.dart';

class ConstructorTemplate extends Template {
  ConstructorTemplate(this.constructorData, this.fieldNameToValue);

  final ConstructorData constructorData;
  final Map<String, String> fieldNameToValue;

  @override
  void write(StringBuffer buffer) {
    final inRequired = <String>{};
    final inNamed = <String>{};
    final inOptional = <String>{};

    for (final field in fieldNameToValue.entries) {
      constructorData.parameterNameToType[field.key]?.when(
        () => inRequired.add('${field.value},'),
        () => inNamed.add('${field.key}: ${field.value},'),
        () => inOptional.add('${field.value},'),
      );
    }

    buffer
      ..writeln(constructorData.constructorName)
      ..write('(')
      ..writeAll(inRequired)
      ..writeAll(inNamed.isNotEmpty ? inNamed : inOptional)
      ..write(')');
  }
}
