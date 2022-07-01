import 'dart:developer';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

class BenchmarkScoreEmitter extends ScoreEmitter {
  BenchmarkScoreEmitter();

  @override
  void emit(String testName, double value) {
    log(value.toString(), name: testName);
  }
}

class ColorEncoderBenchmark extends BenchmarkBase {
  ColorEncoderBenchmark()
      : super('Encoder: Color', emitter: BenchmarkScoreEmitter());

  final ColorEncoder encoder = const ColorEncoder();

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class ColorEncoderNullableBenchmark extends BenchmarkBase {
  ColorEncoderNullableBenchmark()
      : super('Encoder: Color?', emitter: BenchmarkScoreEmitter());

  final ColorEncoderNullable encoder = const ColorEncoderNullable();

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}
