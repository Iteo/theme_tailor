import 'package:meta/meta_meta.dart';

import '../model/theme_encoder.dart';

@Target({TargetKind.classType})
abstract class TailorProp {
  const TailorProp(
    this.prop,
    this.values, {
    this.encoder,
  });

  /// Name of the prop in the generated theme
  final String prop;

  /// Value of the theme prop per theme
  final List values;

  /// Value interpolation
  final ThemeEncoder? encoder;
}

abstract class TailorColor extends TailorProp {
  const TailorColor(super.prop, super.values);
}

abstract class TailorText extends TailorProp {
  const TailorText(super.prop, super.values);
}
