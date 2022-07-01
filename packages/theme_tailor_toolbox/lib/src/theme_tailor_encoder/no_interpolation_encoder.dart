import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class NoIntepolationEncoder<T> extends ThemeEncoder<T> {
  const NoIntepolationEncoder();

  @override
  T lerp(T a, T b, double t) => t < 0.5 ? a : b;
}
