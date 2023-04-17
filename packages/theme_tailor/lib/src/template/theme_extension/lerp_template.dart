import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/template/template.dart';

class LerpTemplate extends Template {
  const LerpTemplate(
    this.className,
    this.fields,
    this.encoderManager,
  );

  final String className;
  final List<Field> fields;
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
