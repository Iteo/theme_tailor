import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/template/template.dart';

class DebugFillPropertiesTemplate extends Template {
  const DebugFillPropertiesTemplate(this.className, this.fields);

  final String className;
  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    String prop(String name, String value) {
      return "..add(DiagnosticsProperty($name, $value))";
    }

    buffer
      ..writeln(
          '@override void debugFillProperties(DiagnosticPropertiesBuilder properties) {')
      ..writeln('super.debugFillProperties(properties);')
      ..writeln('properties')
      ..writeln(prop("'type'", "'$className'"))
      ..writeAll(fields.map((e) => prop("'${e.name}'", e.name)))
      ..write(';}');
  }
}
