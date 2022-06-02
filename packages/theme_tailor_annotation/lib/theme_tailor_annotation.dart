library theme_tailor_annotation;

import 'package:meta/meta_meta.dart';

typedef Lerp<T> = T Function(T a, T b, double t);
typedef TransformData<TIn, TOut> = TOut Function(TIn v, int i);

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

@Target({TargetKind.classType})
class Tailor {
  const Tailor(this.props, [this.themes = const ['light', 'dark']]);

  final Map<String, BaseProp> props;
  final List<String> themes;
}

abstract class BaseProp<T, E> {
  const BaseProp(this.values, this.encoder);

  final List<T> values;
  final ThemeEncoder<T, E>? encoder;
}

abstract class Prop<T> extends BaseProp<T, T> {
  const Prop(List<T> values) : super(values, null);
}
