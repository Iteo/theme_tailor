import 'package:meta/meta_meta.dart';

/// Hints generator that the type conforms to ThemeExtension and can call lerp()
/// on it.
const themeExtension = _ThemeExtension();

@Target({TargetKind.field})
class _ThemeExtension {
  const _ThemeExtension();
}
