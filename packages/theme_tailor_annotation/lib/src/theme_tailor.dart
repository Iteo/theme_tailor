import 'package:meta/meta_meta.dart';

const tailor = Tailor();

/// {@template theme_tailor.theme_tailor}
/// ### Tailor
///
/// {@endtemplate}
///
@Target({TargetKind.classType})
class Tailor {
  const Tailor({this.themes = const ['light', 'dark']});

  final List<String> themes;
}
