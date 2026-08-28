import 'dart:math';

import 'package:example/primary_constructor.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test(
    'PrimaryConstructor named parameters',
    () {
      final _ = PrimaryConstructor2(
        color: Colors.red,
        text: const TextStyle(color: Colors.blue),
      );
      final _ = PrimaryConstructor2(
        color: Colors.green,
        text: const TextStyle(color: Colors.yellow),
      );
    },
  );

  test(
    'PrimaryConstructor positional parameters',
    () {
      final a = PrimaryConstructor(
        Colors.red,
        const TextStyle(color: Colors.blue),
        Colors.blue,
      );
      final b = PrimaryConstructor(
        Colors.green,
        const TextStyle(color: Colors.yellow),
        null,
      );

      // `PrimaryConstructor` example theme class uses custom encoders for lerping.
      expect(
        a.lerp(b, /*This does not matter*/ Random(0).nextDouble()),
        PrimaryConstructor(
          PrimaryConstructorColorEncoder.color,
          const TextStyle(color: PrimaryConstructorColorEncoder.color),
          PrimaryConstructorColorEncoder.color,
        ),
      );
    },
  );
}
