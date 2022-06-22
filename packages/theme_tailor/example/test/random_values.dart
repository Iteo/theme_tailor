import 'dart:math';

import 'package:flutter/material.dart';

int randomInt() {
  final rnd = Random();
  return rnd.nextInt(1000);
}

Color randomColor() {
  final rnd = Random();
  return Color.fromARGB(
    rnd.nextInt(255),
    rnd.nextInt(255),
    rnd.nextInt(255),
    rnd.nextInt(255),
  );
}

TextStyle randomTextStyle() {
  final rnd = Random();
  return TextStyle(
    color: randomColor(),
    height: rnd.nextDouble() * 16.0,
  );
}
