/// ### ThemeGetter
/// Generate getters on ThemeData or BuildContext for alternative access
/// to theme properties.
///
/// #### ThemeGetter.none
/// {@macro theme_tailor.theme_getter.none}
///
/// #### ThemeGetter.onThemeData
/// {@macro theme_tailor.theme_getter.onThemeData}
///
/// #### ThemeGetter.onThemeDataProps
/// {@macro theme_tailor.theme_getter.onThemeDataProps}
///
/// #### ThemeGetter.onBuildContext
/// {@macro theme_tailor.theme_getter.onBuildContext}
///
/// #### ThemeGetter.onBuildContextProps
/// {@macro theme_tailor.theme_getter.onBuildContextProps}
enum ThemeGetter {
  /// {@template theme_tailor.theme_getter.none}
  /// No extension on ThemeData nor BuildContext will be generated,
  /// ```dart
  /// final background = Theme.of(context).extension<MyTheme>()!.background;
  /// ```
  /// {@endtemplate}
  none,

  /// {@template theme_tailor.theme_getter.onThemeData}
  /// Add extension on ThemeData with one getter to the
  /// generated ThemeExtension<T> class
  /// ```dart
  /// final background = Theme.of(context).myTheme.background;
  /// ```
  /// {@endtemplate}
  ///
  /// #### Generated extension:
  /// ```dart
  /// extension MyThemeExtension on ThemeData {
  ///   MyTheme get myTheme => extension<MyTheme>()!;
  /// }
  /// ```
  onThemeData,

  /// {@template theme_tailor.theme_getter.onThemeDataProps}
  /// Add extension on ThemeData with getters to the
  /// properties of the generated theme class.
  /// ```dart
  /// final background = Theme.of(context).background;
  /// ```
  /// {@endtemplate}
  ///
  /// #### Generated extension:
  /// ```dart
  /// extension MyThemeExtension on ThemeData {
  ///   MyTheme get _myTheme => extension<MyTheme>()!;
  ///
  ///   /// Theme data may already have property like this!
  ///   Color get bacground => _myTheme.background;
  /// }
  /// ```
  onThemeDataProps,

  /// {@template theme_tailor.theme_getter.onBuildContext}
  /// Add extension on BuildContext with one getter to the
  /// generated ThemeExtension<T> class
  /// ```dart
  /// final background = context.myTheme.background;
  /// ```
  /// {@endtemplate}
  ///
  /// #### Generated extension:
  /// ```dart
  /// extension MyThemeExtension on BuildContext {
  ///   MyTheme get myTheme => Theme.of(this).extension<MyTheme>()!;
  /// }
  /// ```
  onBuildContext,

  /// {@template theme_tailor.theme_getter.onBuildContextProps}
  /// Add extension on BuildContext with getters to the
  /// properties of the generated theme class.
  /// ```dart
  /// final background = context.background;
  /// ```
  /// {@endtemplate}
  ///
  /// #### Generated extension:
  /// ```dart
  /// extension MyThemeExtension on BuildContext {
  ///   MyTheme get _myTheme => Theme.of(this).extension<MyTheme>()!;
  ///
  ///   Color get background => _myTheme.background;
  /// }
  /// ```
  onBuildContextProps,
}
