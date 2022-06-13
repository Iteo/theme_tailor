// ignore_for_file: unused_element

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

@tailor
class _$MyTheme {
  /// Declared properties
  // List<Color> surface = [Colors.white, Colors.black];
}

@Tailor(themes: ['superLight'])
class _$MyTheme2 {
  /// Declared properties
  // List<Color> surface = [Colors.white];
}

/// ThemeGetter can be used to generate additional extension to access theme from
/// * BuildContext
/// * ThemeData
@Tailor(themeGetter: ThemeGetter.none)
class _$MyTheme3 {
  /// Declared properties
  // List<Color> surface = [Colors.white, Colors.black];
}
