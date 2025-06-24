import 'package:theme_tailor/src/model/constructor_data.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/template/class_instance_template.dart';
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
        ..writeAll(fields.map((e) {
          final annotation = e.annotations.join(' ');
          final preparedAnnotation = annotation.isEmpty ? '' : '$annotation ';
          return '${preparedAnnotation}${e.type.asNullableType} ${e.name},';
        }))
        ..write('}');
    }

    buffer
      ..write(') {')
      ..writeln('return ')
      ..template(
        ClassInstanceTemplate(
          constructorName: constructorData?.constructorName ?? className,
          fieldNameToParamType: constructorData?.parameterNameToType,
          fieldNameToValue: fields.map((e) {
            return MapEntry(e.name, '${e.name} ?? this.${e.name}');
          }),
        ),
      )
      ..write(';}');
  }
}
