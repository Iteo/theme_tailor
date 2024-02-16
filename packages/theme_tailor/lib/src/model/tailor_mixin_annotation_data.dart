import 'package:theme_tailor/src/model/theme_encoder_data.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class TailorMixinAnnotationData {
  const TailorMixinAnnotationData({
    required this.encoders,
    required this.themeGetter,
    required this.themeClassName,
    this.themeDataClassName,
  });

  final Map<String, ThemeEncoderData> encoders;
  final ThemeGetter themeGetter;
  final String themeClassName;
  final String? themeDataClassName;
}
