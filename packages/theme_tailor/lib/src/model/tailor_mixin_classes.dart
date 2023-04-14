import 'package:theme_tailor/src/model/field.dart';
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
  final List<Field> fields;
  final ThemeEncoderManager encoderDataManager;
  final bool hasDiagnosticableMixin;
  final ExtensionData extensionData;
}
