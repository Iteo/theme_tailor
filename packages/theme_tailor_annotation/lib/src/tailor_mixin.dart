import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/src/theme_tailor.dart';

/// {@template theme_tailor.tailor_mixin}
/// ### TailorMixin
/// An annotation to mark a class that needs a mixin that implements ThemeExtension
/// class methods
/// {@endtemplate}
const tailorMixin = TailorMixin();

@Target({TargetKind.classType})

/// {@macro theme_tailor.tailor_mixin}
class TailorMixin extends Tailor {
  /// {@macro theme_tailor.tailor_mixin}
  const TailorMixin({super.themeGetter})
      : super(
          encoders: const [],
          generateStaticGetters: false,
          requireStaticConst: false,
          themes: const [],
        );
}
