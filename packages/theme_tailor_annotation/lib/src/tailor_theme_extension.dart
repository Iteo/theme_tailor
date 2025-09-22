import 'package:meta/meta_meta.dart';

/// Hints generator that the type conforms to ThemeExtension and can call lerp()
/// on it.
const themeExtension = TailorThemeExtension();

@Target({TargetKind.field})
class TailorThemeExtension {
  const TailorThemeExtension();
}
