import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class CopyWithTemplate extends Template {
  const CopyWithTemplate(this.className, this.fields);

  final String className;
  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    buffer.writeln('@override $className copyWith(');

    if (fields.isNotEmpty) {
      buffer
        ..write('{')
        ..writeAll(fields.map((e) => '${e.type.asNullableType} ${e.name},'))
        ..write('}');
    }

    buffer
      ..write(') {')
      ..writeln('return $className(')
      ..writeAll(fields.map((e) => '${e.name}: ${e.name} ?? this.${e.name},'))
      ..writeln(');}');
  }
}
