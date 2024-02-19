import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme_tailor_mixin.g.dart';

const tailorMixin = TailorMixin();

/// {@template theme_tailor.tailor_mixin}
/// ### TailorMixin
/// An annotation to mark a class that needs a mixin that implements ThemeExtension
/// class methods
/// {@endtemplate}
@Target({TargetKind.classType})
@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
  anyMap: true,
)
class TailorMixin {
  /// {@macro theme_tailor.tailor_mixin}
  const TailorMixin({
    this.themeGetter,
    this.encoders,
    this.themeClassName,
    this.themeDataClassName,
  });

  factory TailorMixin.fromJson(Map<String, dynamic> json) => _$TailorMixinFromJson(json);

  /// Create getters for the easy access of the theme properties
  /// In case of creating component/modular themes, set it to
  /// [ThemeGetter.none]
  final ThemeGetter? themeGetter;

  /// A list of [ThemeEncoder]s to apply to this class.
  /// If this is null, default encoders will be used
  ///
  /// ```dart
  /// @TailorMixin(encoders: [CustomColorEncoder()])
  /// class ExampleTheme extends ThemeExtension<ExampleTheme> with _$ExampleThemeTailorMixin {...}
  /// ```
  ///
  /// is equivalent to writing:
  ///
  /// ```dart
  /// @TailorMixin()
  /// @CustomColorEncoder()
  /// class ExampleTheme extends ThemeExtension<ExampleTheme> with _$ExampleThemeTailorMixin {...}
  /// ```
  ///
  /// It allows to reuse tailor annotation across several theme classes
  ///
  /// ```dart
  /// const myCustomAnnotation = TailorMixin(
  ///   encoders: [CustomColorEncoder()],
  /// );
  ///
  /// @myCustomAnnotation
  /// class ExampleTheme extends ThemeExtension<ExampleTheme> with _$ExampleThemeTailorMixin {...}
  ///
  /// @myCustomAnnotation
  /// class OtherExampleTheme extends ThemeExtension<OtherExampleTheme> with _$OtherExampleThemeTailorMixin {...}
  /// ```
  // ignore: deprecated_member_use
  @JsonKey(ignore: true)
  final List<ThemeEncoder>? encoders;

  /// String value of class name, If a theme other than Material is used,
  /// you can specify the theme class name, and the [themeGetter] will generate the getter
  /// of the class type.
  ///
  /// This option generate for themeGetter = ThemeGetter.onBuildContext / ThemeGetter.onBuildContextProps
  ///
  /// To use this option, make sure to import `package:your_theme/your_theme.dart`
  ///
  /// Here's an example usage:
  /// ```dart
  /// @TailorMixin(
  ///   themeGetter: ThemeGetter.onBuildContext,
  ///   themeClassName: 'YourTheme',
  /// )
  /// class _$MyThemes extends ThemeExtension<_$MyThemes> with _$_$MyThemesTailorMixin {
  ///   _$MyThemes({ required this.background });
  ///
  ///   @override
  ///   final Color background;
  /// }
  /// ```
  ///
  /// The generator will generate an extension:
  ///
  /// ```dart
  /// extension MyThemesBuildContext on BuildContext {
  ///   MyThemes get simpleTheme => YourTheme.of(this).extension<MyThemes>()!;
  /// }
  /// ```
  ///
  final String? themeClassName;

  /// String value of class name for themeData, If a theme other than Material is used,
  /// you can specify the themeData class name, and the [themeGetter] will generate the getter
  /// of the class type.
  ///
  /// This option generate for themeGetter = ThemeGetter.onThemeData / ThemeGetter.onThemeDataProps
  ///
  /// To use this option, make sure to import `package:your_theme/your_theme.dart`
  ///
  /// Here's an example usage:
  /// ```dart
  /// @TailorMixin(
  ///   themeGetter: ThemeGetter.onThemeData,
  ///   themeDataClassName: 'YourThemeData',
  /// )
  /// class _$MyThemes extends ThemeExtension<_$MyThemes> with _$_$MyThemesTailorMixin {
  ///    _$MyThemes({ required this.background });
  ///
  ///    @override
  ///    Color background;
  /// }
  /// ```
  ///
  /// The generator will generate an extension:
  ///
  /// ```dart
  /// extension MyThemesThemeData on YourThemeData {
  ///   MyThemes get myThemes => extension<MyThemes>()!;
  /// }
  /// ```
  ///
  final String? themeDataClassName;
}
