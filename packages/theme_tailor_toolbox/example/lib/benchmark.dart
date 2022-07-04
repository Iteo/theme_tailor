// ignore_for_file: implementation_imports

import 'dart:developer';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/color_encoder.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/material_color_encoder.dart';

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

  final ColorNullEncoder encoder = const ColorNullEncoder();

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialColorEncoderBenchmark extends BenchmarkBase {
  MaterialColorEncoderBenchmark()
      : super('Encoder: MaterialColor', emitter: BenchmarkScoreEmitter());

  final MaterialColorEncoder encoder = const MaterialColorEncoder();

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialColorEncoderNullableBenchmark extends BenchmarkBase {
  MaterialColorEncoderNullableBenchmark()
      : super('Encoder: MaterialColor?', emitter: BenchmarkScoreEmitter());

  final MaterialColorNullEncoder encoder = const MaterialColorNullEncoder();

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialAccentColorEncoderBenchmark extends BenchmarkBase {
  MaterialAccentColorEncoderBenchmark()
      : super('Encoder: MaterialAccentColor', emitter: BenchmarkScoreEmitter());

  final MaterialAccentColorEncoder encoder = const MaterialAccentColorEncoder();

  @override
  void run() {
    encoder.lerp(Colors.amberAccent, Colors.pinkAccent, 0.3);
  }
}

class MaterialAccentColorEncoderNullableBenchmark extends BenchmarkBase {
  MaterialAccentColorEncoderNullableBenchmark()
      : super('Encoder: MaterialAccentColor?',
            emitter: BenchmarkScoreEmitter());

  final MaterialAccentColorNullEncoder encoder =
      const MaterialAccentColorNullEncoder();

  @override
  void run() {
    encoder.lerp(Colors.amberAccent, Colors.pinkAccent, 0.3);
  }
}
