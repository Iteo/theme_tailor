import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// Default implementation of non linear interpolation.
/// Encoder will use either first or second value depending on t value
/// (No interpolation will take place)
/// ```dart
/// const dontLerpColor = NoLerpEncoder<Color>();
/// ```
class NoLerpEncoder<T> extends ThemeEncoder<T> {
  const NoLerpEncoder();

  @override
  T lerp(T a, T b, double t) => t < 0.5 ? a : b;
}
