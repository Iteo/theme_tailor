import 'package:example/benchmark.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(home: MyHomePage());
}

class MyHomePage extends StatelessWidget {
  MyHomePage({super.key});

  final _counter = ValueNotifier<int>(0);
  final _canTap = ValueNotifier<bool>(true);

  final _colorEncoderBenchmark = ColorEncoderBenchmark();
  final _colorEncoderNullableBenchmark = ColorEncoderNullableBenchmark();

  void onTap() {
    _canTap.value = false;
    _counter.value++;
    _colorEncoderBenchmark.report();
    _colorEncoderNullableBenchmark.report();
    _canTap.value = true;
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
      floatingActionButton: ValueListenableBuilder<bool>(
        valueListenable: _canTap,
        builder: (context, canTap, child) => FloatingActionButton(
          onPressed: _canTap.value ? onTap : null,
          tooltip: 'Increment',
          child: child,
        ),
        child: Opacity(
          opacity: _canTap.value ? 1 : 0.5,
          child: const Icon(Icons.play_arrow),
        ),
      ),
    );
  }
}
