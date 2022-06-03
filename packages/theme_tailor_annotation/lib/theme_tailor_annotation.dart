library theme_tailor_annotation;

import 'package:meta/meta_meta.dart';

typedef Lerp<T> = T Function(T a, T b, double t);
typedef TransformData<TFrom, TTo> = TTo Function(TFrom v, int i);

abstract class ThemeEncoder<TIn, TOut> {
  const ThemeEncoder();

  /// Value preprocessing
  /// (Preprocessed value will be encoded directly in the theme)
  /// If preprocessing is null - no processing will take place
  TransformData<TIn, TOut>? get transformData;

  /// Value interpolation
  Lerp<TOut> get lerp;
}

abstract class SimpleThemeEncoder<TOut> extends ThemeEncoder<TOut, TOut> {
  const SimpleThemeEncoder();

  /// Only [ThemeEncoder] can transform data
  @override
  TransformData<TOut, TOut>? get transformData => throw UnsupportedError('Only ThemeEncoder can transform data');
}

@Target({TargetKind.classType, TargetKind.getter})
class Sewing {
  const Sewing(this.encoder);

  final ThemeEncoder? encoder;
}

@Target({TargetKind.classType})
class Tailor {
  const Tailor([this.themes = const ['light', 'dark']]);

  final List<String> themes;
}
