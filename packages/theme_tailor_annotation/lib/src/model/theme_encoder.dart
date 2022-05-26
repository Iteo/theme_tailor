import 'typedefs.dart';

abstract class ThemeEncoder<T> {
  const ThemeEncoder();

  /// Value interpolation
  Lerp<T> get lerp;

  /// String builder for the value
  Stringify<T> get stringify;
}
