import 'package:meta/meta_meta.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

const tailor = Tailor();

/// {@template theme_tailor.theme_tailor}
/// ### Tailor
///
/// {@endtemplate}
///
@Target({TargetKind.classType})
class Tailor {
  const Tailor({
    this.themes = const ['light', 'dark'],
    this.encoders,
  });

  final List<String> themes;

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
  /// It allows to reuse tailor annotation accross several theme classes
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
}
