import 'package:theme_tailor/src/model/constructor_data.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/template/constructor_template.dart';
import 'package:theme_tailor/src/template/template.dart';

class LerpTemplate extends Template {
  const LerpTemplate(
    this.className,
    this.fields,
    this.encoderManager, [
    this.constructorData,
  ]);

  final String className;
  final List<Field> fields;
  final ThemeEncoderManager encoderManager;
  final ConstructorData? constructorData;

  @override
  void write(StringBuffer buffer) {
    buffer
      ..writeln(
          '@override $className lerp(covariant ThemeExtension<$className>? other, double t) {')
      ..writeln('if (other is! $className) return this as $className;')
      ..writeln('return ')
      ..writeln(ConstructorTemplate(
        constructorName: constructorData?.constructorName ?? className,
        fieldNameToParamType: constructorData?.parameterNameToType,
        fieldNameToValue: fields.map((e) => MapEntry(
              e.name,
              e.isThemeExtension
                  ? _themeExtensionLerp(e.name, e.type, e.isNullable)
                  : _typeOrEncoderLerp(e.name, e.type),
            )),
      ))
      ..writeln(';}');
  }

  String _themeExtensionLerp(String name, String type, bool isNullable) {
    return "$name${isNullable ? '?' : ''}.lerp(other.$name, t) as $type";
  }

  String _typeOrEncoderLerp(String name, String type) {
    final encoder = encoderManager.encoderFromField(name, type);
    return encoder.callLerp(name, 'other.$name', 't');
  }
}
