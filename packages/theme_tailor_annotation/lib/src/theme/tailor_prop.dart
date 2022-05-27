import 'package:meta/meta_meta.dart';

import '../model/text_data.dart';
import '../model/theme_encoder.dart';

@Target({TargetKind.classType})
abstract class TailorProp<T> {
  const TailorProp(
    this.prop,
    this.values, {
    this.encoder,
  });

  /// Name of the prop in the generated theme
  final String prop;

  /// Value of the theme prop per theme
  final List<T> values;

  /// Value interpolation
  final ThemeEncoder<T>? encoder;
}

abstract class TailorColor extends TailorProp {
  const TailorColor(super.prop, super.values);
}

abstract class TailorText extends TailorProp<TextData> {
  const TailorText(super.prop, super.values);
}
