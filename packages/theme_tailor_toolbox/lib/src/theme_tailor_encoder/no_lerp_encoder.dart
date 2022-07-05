import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class NoLerpEncoder<T> extends ThemeEncoder<T> {
  const NoLerpEncoder();

  @override
  T lerp(T a, T b, double t) => t < 0.5 ? a : b;
}
