import 'package:example/app_colors.dart';
import 'package:example/diagnosticable_lib.dart';

part 'main.tailor.dart';

@TailorMixin()
class const SimpleTheme({
  @override required final Color background,
  @override required final Color appBar,
  @override required final TextStyle h1,
  @override required final TextStyle h2,
}) extends ThemeExtension<SimpleTheme> with _$SimpleThemeTailorMixin {
  static const light = SimpleTheme(
    background: AppColors.white,
    appBar: Colors.amber,
    h1: TextStyle(fontSize: 15, color: Colors.black87),
    h2: TextStyle(fontSize: 14, color: Colors.amber),
  );

  static const dark = SimpleTheme(
    background: Colors.black,
    appBar: Colors.indigo,
    h1: TextStyle(fontSize: 15, color: Colors.white),
    h2: TextStyle(fontSize: 14, color: Colors.lightBlueAccent),
  );
}

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeModeNotifier = ValueNotifier(ThemeMode.light);

  @override
  Widget build(BuildContext context) {
    final lightThemeData = ThemeData(
      brightness: Brightness.light,
      extensions: const [SimpleTheme.light],
    );
    final darkThemeData = ThemeData(
      brightness: Brightness.dark,
      extensions: const [SimpleTheme.dark],
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

class const MyHomePage({
  required final String title,
  required final ValueNotifier<ThemeMode> themeModeNotifier,
  super.key,
}) extends StatefulWidget {
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
          spacing: 20,
          children: <Widget>[
            Text(
              'You have pushed the button\nthis many times:',
              textAlign: TextAlign.center,
              style: customTheme.h1,
            ),
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
        spacing: 10,
        children: [
          FloatingActionButton(
            onPressed: _increment,
            tooltip: 'Increment',
            backgroundColor: customTheme.appBar,
            foregroundColor: customTheme.h1.color,
            child: const Icon(Icons.add),
          ),
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
