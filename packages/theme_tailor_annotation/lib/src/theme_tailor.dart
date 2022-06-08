import 'package:meta/meta_meta.dart';

import 'theme_getter.dart';

const tailor = Tailor();

/// {@template theme_tailor.theme_tailor}
/// ### Tailor
///
/// {@endtemplate}
@Target({TargetKind.classType})
class Tailor {
  /// {@macro theme_tailor.theme_tailor}
  const Tailor({
    this.themes = const ['light', 'dark'],
    this.themeGetter = ThemeGetter.onBuildContextProps,
  });

  final List<String> themes;

  /// Create getters for the easy access of the theme properties
  /// In case of creating component/modular themes, set it to
  /// [ThemeGetter.none]
  final ThemeGetter themeGetter;
}
