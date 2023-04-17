import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/src/tailor_mixin.dart';
import 'package:theme_tailor_annotation/src/theme_getter.dart';

/// {@template theme_tailor.tailor_mixin_component}
/// ### TailorMixinComponent
/// An annotation to mark a class that needs a mixin that implements ThemeExtension
/// class methods. This does not generate any extensions on BuildContext / ThemeData
/// {@endtemplate}
const tailorMixinComponent = TailorMixinComponent();

@Target({TargetKind.classType})

/// {@macro theme_tailor.tailor_mixin_component}
class TailorMixinComponent extends TailorMixin {
  /// {@macro theme_tailor.tailor_mixin_component}
  const TailorMixinComponent() : super(themeGetter: ThemeGetter.none);
}
