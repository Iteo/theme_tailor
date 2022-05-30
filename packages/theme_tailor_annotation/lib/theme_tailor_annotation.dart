library theme_tailor_annotation;

import 'package:meta/meta_meta.dart';

typedef Lerp<T> = T Function(T a, T b, double t);
typedef Stringify<T> = String Function(T v);
typedef TransformData<TIn, TOut> = TOut Function(TIn v, int i);

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

abstract class SimpleThemeEncoder<TOut> extends ThemeEncoder<TOut, TOut> {
  const SimpleThemeEncoder();

  /// Only [ThemeEncoder] can transform data
  @override
  TransformData<TOut, TOut>? get transformData => throw UnsupportedError('Only ThemeEncoder can transform data');
}

const tailor = Tailor();

@Target({TargetKind.classType})
class Tailor {
  const Tailor([this.props = defaultProps, this.themes = defaultThemes]);

  static const String light = 'light';
  static const String dark = 'dark';

  static const List<String> defaultThemes = [light, dark];
  static const List<TailorProp> defaultProps = [
    TailorProp('lucky', [7, 8]),
    TailorProp('themeMode', ['light-mode', 'dark-mode']),
  ];

  final List<String> themes;
  final List<TailorProp> props;
}

class TailorProp<TIn, TOut> {
  const TailorProp(this.name, this.values, {this.encoder});

  /// Name of the prop in the generated theme
  final String name;

  /// Value of the theme prop per theme
  final List<TIn> values;

  /// Value interpolation
  final ThemeEncoder<TIn, TOut>? encoder;
}
