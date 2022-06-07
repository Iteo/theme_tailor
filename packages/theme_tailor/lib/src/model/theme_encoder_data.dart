import 'package:theme_tailor/src/model/field.dart';

class ThemeEncoderData {
  const ThemeEncoderData(this.accessString, this.type, this.lerpAddExclamation);

  factory ThemeEncoderData.className(String className, String accessor, String type) {
    final accessString = 'const $className${_withAccessor(accessor)}()';
    return ThemeEncoderData(accessString, type, false);
  }

  factory ThemeEncoderData.propertyAccess(String accessString, String type) {
    return ThemeEncoderData(accessString, type, false);
  }

  final String accessString;
  final String type;
  final bool lerpAddExclamation;

  String callLerp(String a, String b, String t) {
    return '$accessString.lerp($a, $b, $t)${_withExclamation(lerpAddExclamation)}';
  }

  static String _withExclamation(bool withExclamation) => withExclamation ? '!' : '';

  static String _withAccessor(String accessor) => accessor.isEmpty ? '' : '.$accessor';

  @override
  String toString() => 'accesStr: $accessString, lerpReturnsNullable: $lerpAddExclamation';
}

class DefaultThemeEncoder extends ThemeEncoderData {
  const DefaultThemeEncoder._(super.accessString, super.type, super.lerpAddExclamation);

  static DefaultThemeEncoder instance = const DefaultThemeEncoder._('', 'dynamic', true);

  @override
  String callLerp(String a, String b, String t) {
    return '$t < 0.5? $a : $b';
  }
}

const themeEncoderColor = ThemeEncoderData('Color', 'Color', true);
const themeEncoderColorNullable = ThemeEncoderData('Color', 'Color?', false);

const themeEncoderTextStyle = ThemeEncoderData('TextStyle', 'TextStyle', true);
const themeEncoderTextStyleNullable = ThemeEncoderData('TextStyle', 'TextStyle?', false);

class ThemeEncoderDataManager {
  const ThemeEncoderDataManager._(this.typeToEncoder, this.fieldNameToEncoder);

  factory ThemeEncoderDataManager(
    Map<String, ThemeEncoderData> typeToEncoder,
    Map<String, ThemeEncoderData> fieldNameToEncoder,
  ) {
    final encoders = {
      themeEncoderColor.type: themeEncoderColor,
      themeEncoderColorNullable.type: themeEncoderColorNullable,
      themeEncoderTextStyle.type: themeEncoderTextStyle,
      themeEncoderTextStyleNullable.type: themeEncoderTextStyleNullable,
      ...typeToEncoder,
    };
    return ThemeEncoderDataManager._(encoders, fieldNameToEncoder);
  }

  final Map<String, ThemeEncoderData> typeToEncoder;
  final Map<String, ThemeEncoderData> fieldNameToEncoder;

  ThemeEncoderData encoderFromField(Field field) {
    return fieldNameToEncoder[field.name] ?? typeToEncoder[field.typeStr] ?? DefaultThemeEncoder.instance;
  }
}
