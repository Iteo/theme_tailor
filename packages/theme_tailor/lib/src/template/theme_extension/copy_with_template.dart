import 'package:theme_tailor/src/model/constructor_parameters.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/template/constructor_template.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class CopyWithTemplate extends Template {
  const CopyWithTemplate(this.className, this.fields, [this.constructorData]);

  final String className;
  final List<Field> fields;
  final ConstructorData? constructorData;

  @override
  void write(StringBuffer buffer) {
    buffer.writeln('@override $className copyWith(');

    if (fields.isNotEmpty) {
      buffer
        ..write('{')
        ..writeAll(fields.map((e) => '${e.type.asNullableType} ${e.name},'))
        ..write('}');
    }

    buffer.write(') {');

    if (constructorData != null) {
      buffer.writeln('return ');
      buffer.template(
        ConstructorTemplate(constructorData!, Map.fromEntries(fields.map((e) {
          return MapEntry(e.name, '${e.name} ?? this.${e.name}');
        }))),
      );
      buffer.write(';}');
    } else {
      buffer
        ..writeln('return $className(')
        ..writeAll(fields.map((e) => '${e.name}: ${e.name} ?? this.${e.name},'))
        ..writeln(');}');
    }
  }
}
