import 'dart:ui';

import 'package:example/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'main.tailor.dart';

/// Use @tailor annotation with default values of ['light', 'dark']
@Tailor(themeGetter: ThemeGetter.onBuildContext)
class $_SimpleTheme {
  static const h1Style = TextStyle(fontSize: 15, letterSpacing: 0.3);
  static final h2Style = const TextStyle(fontSize: 14).copyWith(
    fontFeatures: const [FontFeature.proportionalFigures()],
  );

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

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final themeModeNotifier = ValueNotifier(ThemeMode.light);

  final _lightThemeData = ThemeData.light().copyWith(
    extensions: [SimpleTheme.light],
  );
  final _darkThemeData = ThemeData.light().copyWith(
    extensions: [SimpleTheme.dark],
  );

  @override
  Widget build(BuildContext context) {
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
    final customTheme = context.simpleTheme;

    return Scaffold(
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
