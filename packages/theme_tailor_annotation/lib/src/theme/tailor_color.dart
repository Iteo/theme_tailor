import 'dart:ui';

import 'package:theme_tailor_annotation/src/theme/tailor_prop.dart';

class TailorColor extends TailorProp<Color> {
  const TailorColor(super.prop, super.values, super.encoder);
}

class TailorMaybeColor extends TailorProp<Color?> {
  const TailorMaybeColor(super.prop, super.values, super.encoder);
}
