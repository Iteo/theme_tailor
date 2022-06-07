import 'dart:collection';

import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';

class ThemeExtensionClassConfig {
  const ThemeExtensionClassConfig({
    required this.fields,
    required this.returnType,
    required this.baseClassName,
    required this.themes,
    required this.encoderDataManager,
  });

  final SplayTreeMap<String, Field> fields;
  final SplayTreeSet<String> themes;
  final String baseClassName;
  final String returnType;
  final ThemeEncoderDataManager encoderDataManager;
}
