import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// ### NoLerpEncoder
/// The default implementation of non-interpolating encoder.\
/// The encoder will use either first or second value depending on t value
/// ```dart
/// // Example of no-lerping encoder for Color and Color?
/// const dontLerpColor = NoLerpEncoder<Color>();
/// const dontLerpNullableColor = NoLerpEncoder<Color?>();
/// ```
class NoLerpEncoder<T> extends ThemeEncoder<T> {
  const NoLerpEncoder();

  @override
  T lerp(T a, T b, double t) => t < 0.5 ? a : b;
}
