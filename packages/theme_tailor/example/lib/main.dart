import 'package:example/app_colors.dart';
import 'package:example/diagnosticable_lib.dart';

part 'main.tailor.dart';

/// @TailorMixin allows for generating extensions on BuildContext or ThemeData
/// for easier access of the theme properties.
/// for more info check [TailorMixin] and [ThemeGetter] api documentation.
@TailorMixin(themeGetter: ThemeGetter.onBuildContext)
class SimpleTheme extends ThemeExtension<SimpleTheme> with _$SimpleThemeTailorMixin {
  SimpleTheme({
    required this.background,
    required this.appBar,
    required this.h1,
    required this.h2,
  });

  static const h1Style = TextStyle(fontSize: 15, letterSpacing: 0.3);
  static final h2Style = const TextStyle(fontSize: 14).copyWith(
    fontFeatures: const [FontFeature.proportionalFigures()],
  );

  @override
  final Color background;
  @override
  final Color appBar;
  @override
  final TextStyle h1;
  @override
  final TextStyle h2;
}

final lightSimpleTheme = SimpleTheme(
  background: AppColors.white,
  appBar: Colors.amber,
  h1: SimpleTheme.h1Style.copyWith(
    color: const Color.fromARGB(221, 25, 25, 25),
  ),
  h2: SimpleTheme.h2Style.copyWith(color: Colors.amber.shade700),
);

final darkSimpleTheme = SimpleTheme(
  background: Colors.black,
  appBar: Colors.deepPurple,
  h1: SimpleTheme.h1Style.copyWith(color: Colors.grey.shade200),
  h2: SimpleTheme.h2Style.copyWith(color: Colors.blueGrey.shade300),
);

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

  @override
  Widget build(BuildContext context) {
    /// Theme Tailor generates theme extension and these should be included in the
    /// 'extensions' list from the ThemeData.
    final lightThemeData = ThemeData(
      brightness: Brightness.light,
      extensions: [lightSimpleTheme],
    );
    final darkThemeData = ThemeData(
      brightness: Brightness.dark,
      extensions: [darkSimpleTheme],
    );

    return ValueListenableBuilder<ThemeMode>(
      valueListenable: themeModeNotifier,
      builder: (_, themeMode, __) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: lightThemeData,
          darkTheme: darkThemeData,
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
    currentTheme == ThemeMode.light ? widget.themeModeNotifier.value = ThemeMode.dark : widget.themeModeNotifier.value = ThemeMode.light;
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
            backgroundColor: customTheme.appBar,
            foregroundColor: customTheme.h1.color,
            child: const Icon(Icons.add),
          ),
          const SizedBox(width: 10),
          FloatingActionButton(
            onPressed: _swapTheme,
            tooltip: 'Swap theme',
            backgroundColor: customTheme.appBar,
            foregroundColor: customTheme.h1.color,
            child: const Icon(Icons.color_lens),
          ),
        ],
      ),
    );
  }
}
