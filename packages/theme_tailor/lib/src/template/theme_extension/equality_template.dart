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
        'return identical(this, other) || ( other.runtimeType == runtimeType && other is $className',
      );

    for (final field in fields) {
      buffer.writeln(
        ' && const DeepCollectionEquality().equals(${field.name}, other.${field.name})',
      );
    }

    buffer.writeln(');}');
  }
}

class _HashCodeTemplate extends Template {
  const _HashCodeTemplate(this.fields);

  final List<Field> fields;

  @override
  void write(StringBuffer buffer) {
    buffer.writeln('@override int get hashCode {');
    if (fields.isEmpty) {
      _hash0(buffer);
    } else if (fields.length < 20) {
      _hash19(buffer, fields.map((e) => e.name));
    } else {
      _hashAll(buffer, fields.map((e) => e.name));
    }
    buffer.writeln('}');
  }

  String _hash(String fieldName) {
    return 'const DeepCollectionEquality().hash($fieldName),';
  }

  String get _runtimeHashCode => 'runtimeType.hashCode';

  void _hash0(StringBuffer buffer) {
    buffer.write('return $_runtimeHashCode;');
  }

  void _hash19(StringBuffer buffer, Iterable<String> props) {
    buffer
      ..write('return Object.hash(')
      ..write('$_runtimeHashCode,')
      ..writeAll(props.map(_hash))
      ..write(');');
  }

  void _hashAll(StringBuffer buffer, Iterable<String> props) {
    buffer
      ..write('return Object.hashAll([')
      ..write('$_runtimeHashCode,')
      ..writeAll(props.map(_hash))
      ..write(']);');
  }
}
