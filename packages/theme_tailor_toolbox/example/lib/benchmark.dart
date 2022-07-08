// ignore_for_file: implementation_imports

import 'dart:developer';

import 'package:benchmark_harness/benchmark_harness.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

abstract class CustomBenchmarkBase extends BenchmarkBase {
  const CustomBenchmarkBase(super.name, {super.emitter});

  @override
  void exercise() {
    for (var i = 0; i < 1000; i++) {
      run();
    }
  }
}

class BenchmarkScoreEmitter extends ScoreEmitter {
  BenchmarkScoreEmitter();

  @override
  void emit(String testName, double value) {
    log(value.toString(), name: testName);
  }
}

class ColorEncoderBenchmark extends CustomBenchmarkBase {
  ColorEncoderBenchmark()
      : super('Encoder: Color', emitter: BenchmarkScoreEmitter());

  final encoder = EncoderToolbox.colorLerp;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class ColorEncoderNullableBenchmark extends CustomBenchmarkBase {
  ColorEncoderNullableBenchmark()
      : super('Encoder: Color?', emitter: BenchmarkScoreEmitter());

  final encoder = EncoderToolbox.colorNullableLerp;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialColorEncoderBenchmark extends CustomBenchmarkBase {
  MaterialColorEncoderBenchmark()
      : super('Encoder: MaterialColor', emitter: BenchmarkScoreEmitter());

  final encoder = EncoderToolbox.materialColorLerp;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialColorEncoderNullableBenchmark extends CustomBenchmarkBase {
  MaterialColorEncoderNullableBenchmark()
      : super('Encoder: MaterialColor?', emitter: BenchmarkScoreEmitter());

  final encoder = EncoderToolbox.materialColorNullableLerp;

  @override
  void run() {
    encoder.lerp(Colors.amber, Colors.pink, 0.3);
  }
}

class MaterialAccentColorEncoderBenchmark extends CustomBenchmarkBase {
  MaterialAccentColorEncoderBenchmark()
      : super('Encoder: MaterialAccentColor', emitter: BenchmarkScoreEmitter());

  final encoder = EncoderToolbox.materialAccentColorLerp;

  @override
  void run() {
    encoder.lerp(Colors.amberAccent, Colors.pinkAccent, 0.3);
  }
}

class MaterialAccentColorEncoderNullableBenchmark extends CustomBenchmarkBase {
  MaterialAccentColorEncoderNullableBenchmark()
      : super('Encoder: MaterialAccentColor?',
            emitter: BenchmarkScoreEmitter());

  final encoder = EncoderToolbox.materialAccentColorNullableLerp;

  @override
  void run() {
    encoder.lerp(Colors.amberAccent, Colors.pinkAccent, 0.3);
  }
}
