import 'package:flutter/material.dart';

class AppTypography {
  const AppTypography._();

  static Map<String, TextStyle> get allStyles => {
        "style 0": style0,
        "style 1": style1,
        "style 2": style2,
        "style 3": style3,
        "style 4_s": style4s,
        "style 5": style5,
        "style 6": style6,
        "style 6_u": style6u,
        "style 7": style7,
        "style 7_u": style7u,
        "style 8": style8,
        "style 9": style9,
        "style 10": style10,
        "style 10_s": style10s,
        "style 10_u": style10u,
        "style 11": style11,
        "style 11_i": style11i,
        "style 12": style12,
        "style 13": style13,
        "style 14": style14,
        "style 15": style15,
        "style 16": style16,
        "style 16_s": style16s,
        "style 17": style17,
      };

  static const TextStyle style0 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    height: 1.3333333333333333,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    debugLabel: "style0",
  );

  static const TextStyle style1 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 24,
    height: 1.3333333333333333,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    debugLabel: "style1",
  );

  static const TextStyle style2 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 20,
    height: 1.4,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    debugLabel: "style2",
  );

  static const TextStyle style3 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    height: 1.3333333333333333,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    debugLabel: "style3",
  );

  static const TextStyle style4s = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 18,
    height: 1.3333333333333333,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
    debugLabel: "style4s",
  );

  static const TextStyle style5 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 16,
    height: 1.0,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    debugLabel: "style5",
  );

  static const TextStyle style6 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    height: 1.6,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    debugLabel: "style6",
  );

  static const TextStyle style6u = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    height: 1.6,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.underline,
    debugLabel: "style6u",
  );

  static const TextStyle style7 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    height: 1.6,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    debugLabel: "style7",
  );

  static const TextStyle style7u = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    height: 1.6,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    debugLabel: "style7u",
  );

  static const TextStyle style8 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 15,
    height: 1.6,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    debugLabel: "style8",
  );

  static const TextStyle style9 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    height: 1.5384615384615385,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    debugLabel: "style9",
  );

  static const TextStyle style10 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    height: 1.5384615384615385,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    debugLabel: "style10",
  );

  static const TextStyle style10s = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    height: 1.5384615384615385,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.lineThrough,
    debugLabel: "style10s",
  );

  static const TextStyle style10u = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    height: 1.5384615384615385,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.underline,
    debugLabel: "style10u",
  );

  static const TextStyle style11 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    height: 1.5384615384615385,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    debugLabel: "style11",
  );

  static const TextStyle style11i = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 13,
    height: 1.5384615384615385,
    fontStyle: FontStyle.italic,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    debugLabel: "style11i",
  );

  static const TextStyle style12 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    height: 1.3333333333333333,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    debugLabel: "style12",
  );

  static const TextStyle style13 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 12,
    height: 1.3333333333333333,
    fontStyle: FontStyle.normal,
    letterSpacing: -0.2,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    debugLabel: "style13",
  );

  static const TextStyle style14 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    height: 1.4545454545454546,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w700,
    decoration: TextDecoration.none,
    debugLabel: "style14",
  );

  static const TextStyle style15 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    height: 1.4545454545454546,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w600,
    decoration: TextDecoration.none,
    debugLabel: "style15",
  );

  static const TextStyle style16 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    height: 1.4545454545454546,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    debugLabel: "style16",
  );

  static const TextStyle style16s = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 11,
    height: 1.4545454545454546,
    fontStyle: FontStyle.normal,
    letterSpacing: 0.3,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.lineThrough,
    debugLabel: "style16s",
  );

  static const TextStyle style17 = TextStyle(
    fontFamily: 'Montserrat',
    fontSize: 10,
    height: 1.6,
    fontStyle: FontStyle.normal,
    letterSpacing: 0,
    fontWeight: FontWeight.w500,
    decoration: TextDecoration.none,
    debugLabel: "style17",
  );
}
