/// {@template theme_tailor.theme_encoder}
/// ### ThemeEncoder
/// Implement this class to provide custom encoding for a specific [Type]
/// It allows for specyfying custom logic for encoding the theme values.
/// [T] is the type of the encoded data such as "Color" or "TextStyle"
///
/// [ThemeEncoder]s can be placed either on a class or a field
///
/// If field is annotated with [ThemeEncoder] this encoder will be used,
/// otherwise encoders from the @TailorMixin(encoders: [...])
/// or annotations below @TailorMixin() annotation will be used.
/// If no matching encoder for the type is found,
/// default one (dynamic) will be used.
///
/// Default encoders are implemented for:
/// * TextStyle, TextStyle?
/// * Color, Color?
/// * dynamic
///
/// ```dart
/// class CustomColorEncoder extends ThemeEncoder<Color> {
///   const CustomColorEncoder();
///
///   @override
///   Color lerp(Color a, Color b, double t) => t < .5 ? a : b;
/// }
///
/// class CustomTextStyleEncoder extends SimpleEncoder<TextStyle> {
///   const CustomTextStyleEncoder();
/// }
///
/// @TailorMixin()
/// class AppTheme extends ThemeExtension<AppTheme> with _$AppThemeTailorMixin {
///   AppTheme({
///     required this.background,
///     required this.surface,
///     required this.someColors,
///     required this.h1,
///   });
///
///   @CustomColorEncoder()
///   final Color background;
///
///   /// This will use the default encoder for Color
///   final Color surface;
///
///   /// This will the dynamic encoder since the type of the list is dynamic
///   final Color someColors;
///
///   @CustomTextStyleEncoder()
///   final TextStyle h1;
/// }
/// ```
/// {@endtemplate}
abstract class ThemeEncoder<T extends Object?> {
  const ThemeEncoder();

  /// Linearly interpolate between two values.
  /// If any of the value is null, resulting encoded value also is null
  /// The t argument represents the timeline
  /// 0.0: interpolation has not started, returns a;
  /// 1.0: interpolation has finished, returns b;
  T lerp(T a, T b, double t);
}
