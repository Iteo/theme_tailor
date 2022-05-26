import 'package:meta/meta_meta.dart';

@Target({TargetKind.classType})
class ThemeTailor {
  const ThemeTailor(this.themes);

  final List<String> themes;
}
