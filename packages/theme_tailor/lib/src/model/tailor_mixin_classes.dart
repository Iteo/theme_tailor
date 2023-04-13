import 'package:theme_tailor/src/model/theme_encoder_data.dart';

class TailorMixinConfig {
  TailorMixinConfig({
    required this.className,
    required this.fields,
    required this.encoderDataManager,
  });

  final String className;
  final List<TailorMixinField> fields;
  final ThemeEncoderManager encoderDataManager;
}

class TailorMixinField {
  TailorMixinField({
    required this.type,
    required this.name,
    required this.isThemeExtension,
  });

  final String type;
  final String name;
  final bool isThemeExtension;

  bool get isNullable => type.endsWith('?');
}
