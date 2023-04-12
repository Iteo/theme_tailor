import 'package:theme_tailor/src/model/tailor_mixin_classes.dart';
import 'package:theme_tailor/src/util/string_format.dart';

abstract class BufferedTemplate {
  const BufferedTemplate();

  void write(StringBuffer buffer);
}

extension StringBufferExtension on StringBuffer {
  void template(BufferedTemplate template) => template.write(this);
  void emptyLine() => writeln('\n');
}

class TailorMixinTemplate extends BufferedTemplate {
  const TailorMixinTemplate(this.name, this.fields);

  factory TailorMixinTemplate.fromConfig(TailorMixinConfig config) {
    return TailorMixinTemplate(config.className, config.fields);
  }

  final String name;
  final List<TailorMixinField> fields;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln(
          'mixin ${name}TailorMixin on ThemeExtension<$name>, DiagnosticableTreeMixin {')
      ..template(TailorMixinFieldGetterTemplate(fields))
      ..emptyLine()
      ..template(TailorMixinCopyWithTemplate(name, fields))
      ..emptyLine()
      ..template(TailorMixinLerpTemplate(name))
      ..emptyLine()
      ..template(TailorMixinDebugFillPropertiesTemplate(name, fields))
      ..emptyLine()
      ..writeln('}');
  }
}

class TailorMixinFieldGetterTemplate extends BufferedTemplate {
  const TailorMixinFieldGetterTemplate(this.fields);

  final List<TailorMixinField> fields;

  @override
  void write(StringBuffer buffer) {
    buffer.writeAll(fields.map((e) => '${e.type} get ${e.name};'));
  }
}

class TailorMixinCopyWithTemplate extends BufferedTemplate {
  const TailorMixinCopyWithTemplate(this.className, this.fields);

  final String className;
  final List<TailorMixinField> fields;

  @override
  void write(StringBuffer buffer) {
    final fmt = StringFormat();

    buffer
      ..writeln('@override ThemeExtension<$className> copyWith({')
      ..writeAll(fields.map((e) => '${fmt.asNullableType(e.type)} ${e.name},'))
      ..writeln('}) {')
      ..writeln('return $className(')
      ..writeAll(fields.map((e) => '${e.name}: ${e.name} ?? this.${e.name},'))
      ..writeln(');}');
  }
}

class TailorMixinDebugFillPropertiesTemplate extends BufferedTemplate {
  const TailorMixinDebugFillPropertiesTemplate(this.className, this.fields);

  final String className;
  final List<TailorMixinField> fields;

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

class TailorMixinLerpTemplate extends BufferedTemplate {
  const TailorMixinLerpTemplate(this.className);

  final String className;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln(
          '@override ThemeExtension<$className> lerp(covariant ThemeExtension<$className>? other, double t) {')
      ..writeln('throw UnimplementedError();')
      ..writeln('}');
  }
}
