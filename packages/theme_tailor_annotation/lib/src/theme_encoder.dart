/// Implement this class to provide custom encoding for a specific [Type]
/// It allows for specyfying custom logic for encoding the theme values.
/// [T] is the type of the encoded data such as "Color" or "TextStyle"
abstract class ThemeEncoder<T extends Object> {
  const ThemeEncoder();

  /// Linearly interpolate between two values.
  /// If any of the value is null, resulting encoded value also is null
  /// The t argument represents the timeline
  /// 0.0: interpolation has not started, returns a;
  /// 1.0: interpolation has finished, returns b;
  T lerp(T a, T b, double t);
}

/// Implementation of [ThemeEncoder] for any object
/// Value is not interpolated between 2 states and is either A or B
/// Extend SimpleEncoder with a given type to bind it to the theme data type.
/// e.g.:
/// ```dart
/// class ColorSimpleEncoder extends SimpleEncoder<Color> {
///   const ColorSimpleEncoder();
/// }
///
/// const colorEncoder = ColorSimpleEncoder();
/// ```
/// Then use the annotation on the class annotated with @tailor
/// ```dart
/// @tailor
/// @colorEncoder
/// class _$SimpleTheme {}
/// ```
abstract class SimpleThemeEncoder<T extends Object> extends ThemeEncoder<T> {
  const SimpleThemeEncoder();

  @override
  T lerp(T a, T b, double t) => t < .5 ? a : b;
}
