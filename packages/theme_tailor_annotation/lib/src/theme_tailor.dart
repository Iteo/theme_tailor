import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const tailor = Tailor();

/// {@template theme_tailor.theme_tailor}
/// ### Tailor
///
/// {@endtemplate}
@Target({TargetKind.classType})
class Tailor {
  /// {@macro theme_tailor.theme_tailor}
  const Tailor({
    this.themes = const ['light', 'dark'],
    this.themeGetter = ThemeGetter.onBuildContextProps,
    this.encoders,
    this.requireStaticConst = false,
  });

  final List<String> themes;

  /// Create getters for the easy access of the theme properties
  /// In case of creating component/modular themes, set it to
  /// [ThemeGetter.none]
  final ThemeGetter themeGetter;

  /// A list of [ThemeEncoder]s to apply to this class.
  /// If this is null, default encoders will be used
  ///
  /// ```dart
  /// @Tailor(encoders: [CustomColorEncoder()])
  /// class ExampleTheme {...}
  /// ```
  ///
  /// is equivalent to writing:
  ///
  /// ```dart
  /// @Tailor()
  /// @CustomColorEncoder()
  /// class ExampleTheme {...}
  /// ```
  ///
  /// It allows to reuse tailor annotation across several theme classes
  ///
  /// ```dart
  /// const myCustomAnnotation = Tailor(
  ///   encoders: [CustomColorEncoder()],
  /// );
  ///
  /// @myCustomAnnotation
  /// class ExampleTheme {...}
  ///
  /// @myCustomAnnotation
  /// class OtherExampleTheme {...}
  /// ```
  final List<ThemeEncoder>? encoders;

  /// If true, the generator will force generating constant themes.\
  /// However, this feature comes with additional requirements:
  /// - All fields to be included in the theme should be `const List<T>` type
  /// - List length should match theme count, otherwise an error will be thrown
  /// - List initializers should be declared in place, for example:
  ///
  /// ```dart
  /// const someOtherList = ['a','b'];
  ///
  /// @Tailor(requireStaticConst: true)
  /// class _$ConstantThemes {
  ///   // This is correct
  ///   static const someNumberList = [1, 2];
  ///
  ///   // This is bad
  ///   static const otherList = someOtherList;
  /// }
  /// ```
  final bool requireStaticConst;
}
