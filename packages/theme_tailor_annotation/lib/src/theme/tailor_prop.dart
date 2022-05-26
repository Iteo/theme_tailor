import 'package:meta/meta_meta.dart';

import '../model/theme_encoder.dart';

@Target({TargetKind.classType})
abstract class TailorProp<T> {
  const TailorProp(
    this.prop,
    this.values,
    this.encoder,
  );

  /// Name of the prop in the generated theme
  final String prop;

  /// Value of the theme prop per theme
  final List<T> values;

  /// Value interpolation
  final ThemeEncoder<T>? encoder;
}
