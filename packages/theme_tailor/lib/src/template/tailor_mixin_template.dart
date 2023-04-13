import 'package:theme_tailor/src/model/tailor_mixin_classes.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
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
  const TailorMixinTemplate(
    this.name,
    this.fields,
    this.encoderManager,
    this.hasDiagnosticableMixin,
  );

  factory TailorMixinTemplate.fromConfig(TailorMixinConfig config) {
    return TailorMixinTemplate(
      config.className,
      config.fields,
      config.encoderDataManager,
      config.hasDiagnosticableMixin,
    );
  }

  final String name;
  final List<TailorMixinField> fields;
  final ThemeEncoderManager encoderManager;
  final bool hasDiagnosticableMixin;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln('mixin ${name}TailorMixin on ThemeExtension<$name>')
      ..write(hasDiagnosticableMixin ? ',DiagnosticableTreeMixin {' : '{')
      ..template(TailorMixinFieldGetterTemplate(fields))
      ..emptyLine()
      ..template(TailorMixinCopyWithTemplate(name, fields))
      ..emptyLine()
      ..template(TailorMixinLerpTemplate(name, fields, encoderManager))
      ..emptyLine();

    if (hasDiagnosticableMixin) {
      buffer
        ..template(TailorMixinDebugFillPropertiesTemplate(name, fields))
        ..emptyLine();
    }

    buffer
      ..template(TailorMixinEqualTemplate(name, fields))
      ..emptyLine()
      ..template(TailorMixinHashCodeTemplate(fields))
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
      ..writeln('@override $className copyWith({')
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
  const TailorMixinLerpTemplate(
    this.className,
    this.fields,
    this.encoderManager,
  );

  final String className;
  final List<TailorMixinField> fields;
  final ThemeEncoderManager encoderManager;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln(
          '@override $className lerp(covariant ThemeExtension<$className>? other, double t) {')
      ..writeln('if (other is! $className) return this as $className;')
      ..writeln('return $className(');

    for (final prop in fields) {
      if (prop.isThemeExtension) {
        buffer.writeln(_extensionLerp(prop.name, prop.type, prop.isNullable));
      } else {
        buffer.writeln(_encoderLerp(prop.name, prop.type));
      }
    }

    buffer.writeln(');}');
  }

  String _extensionLerp(String name, String type, bool isNullable) {
    return "$name: $name${isNullable ? '?' : ''}.lerp(other.$name, t) as $type,";
  }

  String _encoderLerp(String name, String type) {
    final encoder = encoderManager.encoderFromField(name, type);
    return "$name: ${encoder.callLerp(name, 'other.$name', 't')},";
  }
}

class TailorMixinEqualTemplate extends BufferedTemplate {
  const TailorMixinEqualTemplate(this.className, this.fields);

  final String className;
  final List<TailorMixinField> fields;

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

class TailorMixinHashCodeTemplate extends BufferedTemplate {
  const TailorMixinHashCodeTemplate(this.fields);

  final List<TailorMixinField> fields;

  @override
  void write(StringBuffer buffer) {
    buffer.writeln('@override int get hashCode { return Object.hashAll([');
    for (final field in fields) {
      buffer.writeln('const DeepCollectionEquality().hash(${field.name}),');
    }
    buffer.writeln(']);}');
  }
}
