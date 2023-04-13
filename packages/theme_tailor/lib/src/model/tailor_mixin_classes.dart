import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';

class TailorMixinConfig {
  TailorMixinConfig({
    required this.className,
    required this.fields,
    required this.encoderDataManager,
    required this.hasDiagnosticableMixin,
    required this.extensionData,
  });

  final String className;
  final List<TailorMixinField> fields;
  final ThemeEncoderManager encoderDataManager;
  final bool hasDiagnosticableMixin;
  final ExtensionData extensionData;
}

class TailorMixinField {
  TailorMixinField({
    required this.type,
    required this.name,
    required this.isThemeExtension,
    this.documentationComment,
  });

  final String type;
  final String name;
  final bool isThemeExtension;
  final String? documentationComment;

  bool get isNullable => type.endsWith('?');
}
