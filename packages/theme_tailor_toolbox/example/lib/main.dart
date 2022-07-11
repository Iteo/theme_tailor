import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox_example/benchmark.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: MyHomePage());
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _counter = ValueNotifier<int>(0);

  final _materialColorEncoderNullableBenchmark =
      MaterialColorEncoderNullableBenchmark();
  final _materialAccentColorEncoderNullableBenchmark =
      MaterialAccentColorEncoderNullableBenchmark();

  void onTap() {
    _counter.value++;
    _materialColorEncoderNullableBenchmark.report();
    _materialAccentColorEncoderNullableBenchmark.report();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Benchmark')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Benchmarks'),
            ValueListenableBuilder<int>(
              valueListenable: _counter,
              builder: (_, count, __) => Text('$count'),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: onTap,
        tooltip: 'Increment',
        child: const Icon(Icons.play_arrow),
      ),
    );
  }
}
