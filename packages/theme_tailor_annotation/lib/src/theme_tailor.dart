import 'package:meta/meta_meta.dart';

import '../theme_tailor_annotation.dart';

const tailor = Tailor();

/// {@template theme_tailor.theme_tailor}
/// ### Tailor
///
/// {@endtemplate}
///
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
