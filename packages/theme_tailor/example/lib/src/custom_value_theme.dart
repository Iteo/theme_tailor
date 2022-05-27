// ignore_for_file: unused_element
// TODO(rongix) enable part file generation

import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// Example of a multi - theme application
enum SuperThemeEnum {
  light,
  superLight,
  dark,
  superDark,
}

class SuperThemeEnumEncoder extends ThemeEncoder<SuperThemeEnum> {
  const SuperThemeEnumEncoder();

  @override
  Lerp<SuperThemeEnum> get lerp => (a, b, t) => t < 0.5 ? a : b;

  @override
  Stringify<SuperThemeEnum> get stringify => (v) => v.toString();
}

abstract class TailorSuperThemeEnum extends TailorProp {
  const TailorSuperThemeEnum(super.prop, super.values) : super(encoder: const SuperThemeEnumEncoder());
}

@ThemeTailor(['light', 'superLight', 'dark', 'superDark'])
@TailorSuperThemeEnum(
  'themeType',
  [SuperThemeEnum.light, SuperThemeEnum.superLight, SuperThemeEnum.dark, SuperThemeEnum.superDark],
)
class _$SuperThemeEnumThemeExtension {}
