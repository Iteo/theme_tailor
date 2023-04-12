import 'package:theme_tailor/src/model/field.dart';

class ThemeEncoderData {
  const ThemeEncoderData(
    this.accessString,
    this.type,
    this.lerpAddExclamation,
  );

  factory ThemeEncoderData.className(
    String className,
    String accessor,
    String type,
    bool isGeneric,
  ) {
    final accessString =
        'const $className${_withAccessor(accessor)}${_withType(isGeneric, type)}()';
    return ThemeEncoderData(accessString, type, false);
  }

  factory ThemeEncoderData.propertyAccess(
    String accessString,
    String type,
  ) {
    return ThemeEncoderData(accessString, type, false);
  }

  final String accessString;
  final String type;
  final bool lerpAddExclamation;

  String callLerp(String a, String b, String t) =>
      '$accessString.lerp($a, $b, $t)${_withExclamation(lerpAddExclamation)}';

  static String _withExclamation(bool withExclamation) =>
      withExclamation ? '!' : '';

  static String _withAccessor(String accessor) =>
      accessor.isEmpty ? '' : '.$accessor';

  static String _withType(bool isGeneric, String type) =>
      isGeneric ? '<$type>' : '';

  @override
  String toString() =>
      'accesStr: $accessString, lerpReturnsNullable: $lerpAddExclamation';
}

class _AnyEncoder extends ThemeEncoderData {
  const _AnyEncoder._(
    super.accessString,
    super.type,
    super.lerpAddExclamation,
  );

  static _AnyEncoder instance = const _AnyEncoder._('', '', true);

  @override
  String callLerp(String a, String b, String t) => '$t < 0.5? $a : $b';
}

class ThemeEncoderManager {
  const ThemeEncoderManager._(this.typeToEncoder, this.fieldNameToEncoder);

  factory ThemeEncoderManager(
    Map<String, ThemeEncoderData> typeToEncoder,
    Map<String, ThemeEncoderData> fieldNameToEncoder,
  ) {
    final encoders = {
      ..._defaultEncoders,
      ...typeToEncoder,
    };
    return ThemeEncoderManager._(encoders, fieldNameToEncoder);
  }

  static const _color = ThemeEncoderData('Color', 'Color', true);
  static const _colorNull = ThemeEncoderData('Color', 'Color?', false);
  static const _tStyle = ThemeEncoderData('TextStyle', 'TextStyle', true);
  static const _tStyleNull = ThemeEncoderData('TextStyle', 'TextStyle?', false);

  static const _defaultEncoders = {
    'Color': _color,
    'Color?': _colorNull,
    'TextStyle': _tStyle,
    'TextStyle?': _tStyleNull,
  };

  final Map<String, ThemeEncoderData> typeToEncoder;
  final Map<String, ThemeEncoderData> fieldNameToEncoder;

  ThemeEncoderData encoderFromField(Field field) {
    return fieldNameToEncoder[field.name] ??
        typeToEncoder[field.typeName] ??
        _AnyEncoder.instance;
  }
}
