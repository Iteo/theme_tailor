import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class TailorMixinCopyWithTemplate extends Template {
  const TailorMixinCopyWithTemplate(this.className, this.fields);

  final String className;
  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln('@override $className copyWith({')
      ..writeAll(fields.map((e) => '${e.type.asNullableType} ${e.name},'))
      ..writeln('}) {')
      ..writeln('return $className(')
      ..writeAll(fields.map((e) => '${e.name}: ${e.name} ?? this.${e.name},'))
      ..writeln(');}');
  }
}
