import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/template/template.dart';

class EqualityTemplate extends Template {
  const EqualityTemplate(this.className, this.fields);

  final String className;
  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..template(_EqualTemplate(className, fields))
      ..template(_HashCodeTemplate(fields));
  }
}

class _EqualTemplate extends Template {
  const _EqualTemplate(this.className, this.fields);

  final String className;
  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln('@override bool operator ==(Object other) {')
      ..writeln(
          'return identical(this, other) || ( other.runtimeType == runtimeType && other is $className');

    for (final field in fields) {
      buffer.writeln(
          ' && const DeepCollectionEquality().equals(${field.name}, other.${field.name})');
    }

    buffer.writeln(');}');
  }
}

class _HashCodeTemplate extends Template {
  const _HashCodeTemplate(this.fields);

  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    buffer.writeln('@override int get hashCode { return Object.hashAll([');
    for (final field in fields) {
      buffer.writeln('const DeepCollectionEquality().hash(${field.name}),');
    }
    buffer.writeln(']);}');
  }
}
