// ignore_for_file: unused_element, deprecated_member_use_from_same_package

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

@tailorMixin
class _$MyTheme {
  /// Declared properties
  // List<Color> surface = [Colors.white, Colors.black];
}

/// ThemeGetter can be used to generate additional extension to access theme from
/// * BuildContext
/// * ThemeData
@TailorMixin(themeGetter: ThemeGetter.none)
class _$MyTheme2 {
  /// Declared properties
  // List<Color> surface = [Colors.white, Colors.black];
}
