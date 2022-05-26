import 'package:theme_tailor_annotation/src/theme/tailor_prop.dart';

import '../model/text_data.dart';

class TailorText extends TailorProp<TextData> {
  const TailorText(super.prop, super.values, super.encoder);
}

class TailorMaybeText extends TailorProp<TextData?> {
  const TailorMaybeText(super.prop, super.values, super.encoder);
}
