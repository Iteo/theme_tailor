import 'theme_encoder.dart';



/// {@template theme_tailor.tailor_prop}
/// ### TailorProp
///
/// Annotation for `ThemeTailor` package.
/// Takes 2 required parameters: name, values, and one optional parameter: encoder
/// name - Name of the prop in the generated theme
/// values - Values of the theme prop per theme
/// encoder - Value interpolation
///
/// {@endtemplate}
class TailorProp<TIn, TOut> {
  const TailorProp(this.name, this.values, {this.encoder});

  /// Name of the prop in the generated theme
  final String name;

  /// Values of the theme prop per theme
  final List<TIn> values;

  /// Value interpolation
  final ThemeEncoder<TIn, TOut>? encoder;
}
