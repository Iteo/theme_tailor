import 'package:json_annotation/json_annotation.dart';
import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'theme_tailor.g.dart';

const tailor = Tailor();

/// {@template theme_tailor.theme_tailor}
/// ### Tailor
///
/// {@endtemplate}
@Target({TargetKind.classType})
@JsonSerializable(
  fieldRename: FieldRename.snake,
  createToJson: false,
  anyMap: true,
)
class Tailor {
  /// {@macro theme_tailor.theme_tailor}
  const Tailor({
    this.themes,
    this.themeGetter,
    this.encoders,
    this.requireStaticConst,
    this.generateStaticGetters = true,
  });

  factory Tailor.fromJson(Map json) => _$TailorFromJson(json);

  final List<String>? themes;

  /// Create getters for the easy access of the theme properties
  /// In case of creating component/modular themes, set it to
  /// [ThemeGetter.none]
  final ThemeGetter? themeGetter;

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
  // ignore: deprecated_member_use
  @JsonKey(ignore: true)
  final List<ThemeEncoder>? encoders;

  /// If true, the generator will force generating constant themes.
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
  final bool? requireStaticConst;

  /// If true, static getters will be generated to support updating theme
  /// properties on hot reload. They will conditionally return either a getter
  /// for the theme itself (if kDebugMode == true) or final theme otherwise.
  /// Additional requirements:
  ///  - Any property of the anotated class that you want to be updated
  ///  on hot reload must either be a getter or const.
  ///  - ThemeData has to be declared in place (most often theme property
  ///  of the MaterialApp).
  ///
  /// ```dart
  /// const lightColor = Color(0xFFA1B2C3);
  /// const darkColor = Color(0xFF123ABC);
  ///
  /// @tailor
  /// class _$GetterTheme {
  ///   // This is correct
  ///   static const color1 = [lightColor, darkColor];
  ///   static List<Color> get color2 => [lightColor, darkColor];
  ///
  ///   // This is bad
  ///   static List<Color> color3 = [lightColor, darkColor];
  /// }
  /// ```
  final bool generateStaticGetters;
}
