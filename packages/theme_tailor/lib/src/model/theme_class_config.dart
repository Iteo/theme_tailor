import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';

class ThemeClassConfig {
  const ThemeClassConfig({
    required this.fields,
    required this.themes,
    required this.baseClassName,
    required this.returnType,
    required this.encoderDataManager,
    required this.themeGetter,
  });

  final Map<String, Field> fields;
  final List<String> themes;
  final String baseClassName;
  final String returnType;
  final ThemeEncoderDataManager encoderDataManager;
  final ExtensionData themeGetter;
}
