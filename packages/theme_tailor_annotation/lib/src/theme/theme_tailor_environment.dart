const tailorLight = ThemeTailorEnvironment(ThemeTailorEnvironment.light);
const tailorDark = ThemeTailorEnvironment(ThemeTailorEnvironment.dark);

class ThemeTailorEnvironment {
  const ThemeTailorEnvironment(this.name);

  final String name;

  static const String light = 'light';
  static const String dark = 'dark';
}
