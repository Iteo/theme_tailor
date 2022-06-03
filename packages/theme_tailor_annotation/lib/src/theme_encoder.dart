import '../theme_tailor_annotation.dart';

/// Utility class, allow to encode custom value object into theme value
abstract class ThemeEncoder<TIn, TOut> {
  const ThemeEncoder();

  /// Value preprocessing
  /// (Preprocessed value will be encoded directly in the theme)
  /// If preprocessing is null - no processing will take place
  TransformData<TIn, TOut>? get transformData;

  /// Value interpolation
  Lerp<TOut> get lerp;

  /// String builder for the value
  Stringify<TOut> get stringify;
}

/// Utility class that extends [ThemeEncoder] with the same input and output class type
abstract class SimpleThemeEncoder<TOut> extends ThemeEncoder<TOut, TOut> {
  const SimpleThemeEncoder();

  /// Only [ThemeEncoder] can transform data
  @override
  TransformData<TOut, TOut>? get transformData => throw UnsupportedError('Only ThemeEncoder can transform data');
}