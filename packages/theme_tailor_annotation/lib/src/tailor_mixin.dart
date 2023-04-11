import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/src/theme_tailor.dart';

/// ### TailorMixin
/// An annotation to mark a class that needs a mixin that implements ThemeExtension
/// class methods
@Target({TargetKind.classType})
class TailorMixin extends Tailor {
  const TailorMixin({super.themeGetter})
      : super(
          encoders: const [],
          generateStaticGetters: false,
          requireStaticConst: false,
          themes: const [],
        );
}
