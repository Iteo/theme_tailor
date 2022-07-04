import 'dart:ui';

import 'package:example/app_colors.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'main.tailor.dart';

/// Tailor annotation
/// It can also be called as "@tailor" that has default options visible below.
/// By default 2 themes will be generated, "light" and "dark"
/// Generator will use List values declared in the class to populate these themes
/// Therefore it is expected for the lists to be filled and have proper lengths.
///
/// If you don't want to generate any themes and prefer to create them in a
/// different way, use declaration like this:
/// ```dart
/// @Tailor(themes: [])
/// ```
///
/// @Tailor also allows for generating extensions on BuildContext or ThemeData
/// for easier access of the theme properties.
/// for more info check [Tailor] and [ThemeGetter] api documentation.
///
/// By default generated theme class is the name of the annotated class stripped
/// from '$_' or '_$, in this case: SimpleTheme
@Tailor(
  themes: ['light', 'dark'],
  themeGetter: ThemeGetter.onBuildContext,
)
class $_SimpleTheme {
  /// Only List<> fields are turned into theme properties, h1Style and h2Style
  /// won't be encoded directly in the theme.
  static const h1Style = TextStyle(fontSize: 15, letterSpacing: 0.3);
  static final h2Style = const TextStyle(fontSize: 14).copyWith(
    fontFeatures: const [FontFeature.proportionalFigures()],
  );

  /// Declaration of the fields of the theme, list values are default values
  /// for the generated themes ['light', 'dark']
  /// You can configure ammount of generated themes in the @Tailor "themes".
  static List<Color> background = [AppColors.white, Colors.grey.shade900];
  static List<Color> appBar = [Colors.amber, Colors.blueGrey.shade800];
  static List<TextStyle> h1 = [
    h1Style.copyWith(color: const Color.fromARGB(221, 25, 25, 25)),
    h1Style.copyWith(color: Colors.grey.shade200),
  ];
  static List<TextStyle> h2 = [
    h2Style.copyWith(color: Colors.amber.shade700),
    h2Style.copyWith(color: Colors.blueGrey.shade300),
  ];
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  /// Notifier for handling theme mode changes
  /// replace it with your own state management
  final themeModeNotifier = ValueNotifier(ThemeMode.light);

  /// Theme Tailor generates theme extension and these should be included in the
  /// 'extensions' list from the ThemeData.
  /// If you opted out from generating themes by setting Tailor's "themes" to []
  /// You won't see SimpleTheme.light / SimpleTheme.dark
  final _lightThemeData = ThemeData(
    brightness: Brightness.light,
    extensions: [SimpleTheme.light],
  );
  final _darkThemeData = ThemeData(
    brightness: Brightness.dark,
    extensions: [SimpleTheme.dark],
  );

  @override
  Widget build(BuildContext context) {
    print(_lightThemeData);
    print(SimpleTheme.light);

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (_, themeMode, __) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: _lightThemeData,
          darkTheme: _darkThemeData,
          themeMode: themeMode,
          home: MyHomePage(
            title: 'Theme Tailor Demo',
            themeModeNotifier: themeModeNotifier,
          ),
        );
      },
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    required this.title,
    required this.themeModeNotifier,
    super.key,
  });

  final String title;
  final ValueNotifier<ThemeMode> themeModeNotifier;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final counter = ValueNotifier<int>(0);

  void _increment() => counter.value++;

  void _swapTheme() {
    final currentTheme = widget.themeModeNotifier.value;
    currentTheme == ThemeMode.light
        ? widget.themeModeNotifier.value = ThemeMode.dark
        : widget.themeModeNotifier.value = ThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    /// ThemeGetter.onBuildContext generate extension on BuildContext so it is
    /// possible to access custom theme from context
    /// It is required for the context to contain theme extension,
    /// make sure custom theme is added to the App ThemeData
    /// (In most cases: MaterialApp's theme and darkTheme)
    final customTheme = context.simpleTheme;

    return Scaffold(
      /// background is a generated theme property
      backgroundColor: customTheme.background,
      appBar: AppBar(
        foregroundColor: customTheme.h1.color,
        title: Text(widget.title),
        backgroundColor: customTheme.appBar,
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button\nthis many times:',
              textAlign: TextAlign.center,
              style: customTheme.h1,
            ),
            const SizedBox(height: 20),
            ValueListenableBuilder<int>(
              valueListenable: counter,
              builder: (_, count, __) {
                return Text('$count', style: customTheme.h2);
              },
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _increment,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
            backgroundColor: customTheme.appBar,
            foregroundColor: customTheme.h1.color,
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _swapTheme,
            child: const Icon(Icons.color_lens),
            tooltip: 'Swap theme',
            backgroundColor: customTheme.appBar,
            foregroundColor: customTheme.h1.color,
          ),
        ],
      ),
    );
  }
}
