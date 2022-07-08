import 'dart:math';

import 'package:flutter/material.dart';

Color randomColor([Random? random]) {
  final rnd = random ?? Random();
  return Color.fromARGB(
    rnd.nextInt(255),
    rnd.nextInt(255),
    rnd.nextInt(255),
    rnd.nextInt(255),
  );
}

TextStyle randomTextStyle([Random? random]) {
  final rnd = random ?? Random();
  return TextStyle(
    color: randomColor(),
    height: rnd.nextDouble() * 16.0,
  );
}
