// import 'package:meta/meta_meta.dart';

import 'theme_tailor_environment.dart';

const tailor = ThemeTailor([
  ThemeTailorEnvironment.light,
  ThemeTailorEnvironment.dark,
]);

// @Target({TargetKind.classType})
class ThemeTailor {
  const ThemeTailor(this.themes);

  final List<String> themes;
}
