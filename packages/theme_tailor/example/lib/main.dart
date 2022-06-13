import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'main.tailor.dart';

/// Use @tailor annotation with default values of ['light', 'dark']
@Tailor(themeGetter: ThemeGetter.onBuildContext)
class $_SimpleTheme {
  static List<Color> background = [AppColors.white, AppColors.yellow];
  static List<Color> appBar = [AppColors.orange, AppColors.blue];
  static List<TextStyle> h1 = const [
    TextStyle(color: AppColors.black),
    TextStyle(color: AppColors.orange),
  ];
  static List<TextStyle> h2 = const [
    TextStyle(color: AppColors.orange),
    TextStyle(color: AppColors.black),
  ];
}

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ThemeMode themeMode = ThemeMode.light;
  final SimpleThemeModeController _themeModeController =
      SimpleThemeModeController();

  @override
  void initState() {
    super.initState();
    _themeModeController.onModeChanged(
      (mode) => setState(
        () {
          themeMode = mode;
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData.light().copyWith(extensions: [SimpleTheme.light]),
      darkTheme: ThemeData.dark().copyWith(extensions: [SimpleTheme.dark]),
      themeMode: themeMode,
      home: MyHomePage(
          title: 'Flutter Demo Home Page', themeProvider: _themeModeController),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
    required this.themeProvider,
  }) : super(key: key);

  final String title;
  final SimpleThemeModeController themeProvider;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _swapTheme() {
    widget.themeProvider.swapTheme();
  }

  @override
  Widget build(BuildContext context) {
    SimpleTheme customTheme = context.simpleTheme;

    return Scaffold(
      backgroundColor: customTheme.background,
      appBar: AppBar(
        title: Text(
          widget.title,
          style: customTheme.h1,
        ),
        backgroundColor: customTheme.appBar,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
              style: customTheme.h1,
            ),
            Text(
              '$_counter',
              style: customTheme.h2,
            ),
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: _incrementCounter,
            tooltip: 'Increment',
            child: const Icon(Icons.add),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: _swapTheme,
            tooltip: 'Swap theme',
            child: const Icon(Icons.swap_vert),
          ),
        ],
      ),
    );
  }
}

class SimpleThemeModeController {
  ThemeMode mode;
  void Function(ThemeMode mode)? onModeChangedCallback;

  SimpleThemeModeController({
    this.mode = ThemeMode.light,
  });

  void swapTheme() {
    if (mode == ThemeMode.light) {
      mode = ThemeMode.dark;
    } else {
      mode = ThemeMode.light;
    }
    onModeChangedCallback?.call(mode);
  }

  void onModeChanged(void Function(ThemeMode mode) param0) {
    onModeChangedCallback = param0;
  }
}
