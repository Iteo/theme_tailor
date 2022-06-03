import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// Utility class, allow to encode custom value object into theme value
abstract class ThemeEncoder<T> {
  const ThemeEncoder();

  /// Value interpolation
  Lerp<T> get lerp;
}
