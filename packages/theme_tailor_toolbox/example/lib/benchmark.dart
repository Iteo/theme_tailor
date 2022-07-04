// ignore_for_file: implementation_imports

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

  final encoder = colorEncoder;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class ColorEncoderNullableBenchmark extends BenchmarkBase {
  ColorEncoderNullableBenchmark()
      : super('Encoder: Color?', emitter: BenchmarkScoreEmitter());

  final encoder = colorNullEncoder;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialColorEncoderBenchmark extends BenchmarkBase {
  MaterialColorEncoderBenchmark()
      : super('Encoder: MaterialColor', emitter: BenchmarkScoreEmitter());

  final encoder = materialColorEncoder;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialColorEncoderNullableBenchmark extends BenchmarkBase {
  MaterialColorEncoderNullableBenchmark()
      : super('Encoder: MaterialColor?', emitter: BenchmarkScoreEmitter());

  final encoder = materialColorNullEncoder;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialAccentColorEncoderBenchmark extends BenchmarkBase {
  MaterialAccentColorEncoderBenchmark()
      : super('Encoder: MaterialAccentColor', emitter: BenchmarkScoreEmitter());

  final encoder = materialAccentColorEncoder;

  @override
  void run() {
    encoder.lerp(Colors.amberAccent, Colors.pinkAccent, 0.3);
  }
}

class MaterialAccentColorEncoderNullableBenchmark extends BenchmarkBase {
  MaterialAccentColorEncoderNullableBenchmark()
      : super('Encoder: MaterialAccentColor?',
            emitter: BenchmarkScoreEmitter());

  final encoder = materialAccentColorNullEncoder;

  @override
  void run() {
    encoder.lerp(Colors.amberAccent, Colors.pinkAccent, 0.3);
  }
}
