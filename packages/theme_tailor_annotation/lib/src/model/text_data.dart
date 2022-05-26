import 'package:flutter/material.dart';

class TextData {
  TextData({
    this.fontFamily,
    this.size,
    this.lineHeight,
    this.color,
    this.spacing,
    this.fontWeight,
  });

  final String? fontFamily;
  final double? size;
  final double? lineHeight;
  final Color? color;
  final double? spacing;
  final FontWeight? fontWeight;
}
