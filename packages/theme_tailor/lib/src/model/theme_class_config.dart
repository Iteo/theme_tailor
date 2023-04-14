import 'package:theme_tailor/src/model/annotation_data_manager.dart';
import 'package:theme_tailor/src/model/field.dart';
import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor/src/model/theme_getter_data.dart';

class ThemeClassConfig {
  const ThemeClassConfig({
    required this.fields,
    required this.themes,
    required this.baseClassName,
    required this.className,
    required this.themesFieldName,
    required this.encoderManager,
    required this.themeGetter,
    required this.annotationManager,
    required this.hasDiagnosticableMixin,
    required this.hasJsonSerializable,
    required this.constantThemes,
    required this.staticGetters,
  });

  final Map<String, TailorField> fields;
  final List<String> themes;
  final String baseClassName;
  final String className;
  final String themesFieldName;
  final ThemeEncoderManager encoderManager;
  final ExtensionData themeGetter;
  final AnnotationDataManager annotationManager;
  final bool hasDiagnosticableMixin;
  final bool hasJsonSerializable;
  final bool constantThemes;
  final bool staticGetters;
}
