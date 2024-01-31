// ignore_for_file: deprecated_member_use, unused_element

import 'package:example/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'migration_from_tailor_to_tailor_mixin.tailor.dart';

@Tailor(
  themes: ['light', 'dark'],
  themeGetter: ThemeGetter.onBuildContext,
  generateStaticGetters: true,
)
class $_SimpleTheme {
  static const h1Style = TextStyle(fontSize: 15, letterSpacing: 0.3);

  static const List<Color> background = [AppColors.white, Colors.black];

  static List<TextStyle> h1 = [
    h1Style.copyWith(color: const Color.fromARGB(221, 25, 25, 25)),
    h1Style.copyWith(color: Colors.grey.shade200),
  ];
}

final light = SimpleTheme.light;
final dark = SimpleTheme.dark;

/// Theme looks before migration
final _lightThemeData = ThemeData(
  brightness: Brightness.light,
  extensions: [SimpleTheme.light],
);
final _darkThemeData = ThemeData(
  brightness: Brightness.dark,
  extensions: [SimpleTheme.dark],
);

/// ========== Migrated ============
@TailorMixin()
class MigratedSimpleTheme extends ThemeExtension<MigratedSimpleTheme>
    with _$MigratedSimpleThemeTailorMixin {
  MigratedSimpleTheme({
    required this.background,
    required this.h1,
  });

  @override
  final Color background;
  @override
  final TextStyle h1;
}

/// Theme looks after migration.
/// Create light and dark manually
final migratedSimpleThemeLight = MigratedSimpleTheme(
  background: AppColors.white,
  h1: const TextStyle(color: AppColors.black),
);
final migratedSimpleThemeDart = MigratedSimpleTheme(
  background: AppColors.black,
  h1: const TextStyle(color: AppColors.white),
);

final _lightMigratedThemeData = ThemeData(
  brightness: Brightness.light,
  extensions: [migratedSimpleThemeLight],
);
final _darkMigratedThemeData = ThemeData(
  brightness: Brightness.dark,
  extensions: [migratedSimpleThemeDart],
);
