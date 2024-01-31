// ignore_for_file: unused_element, unused_field, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'constant_theme.tailor.dart';

class Point {
  const Point({required this.x, required this.y});

  final String x;
  final String y;
}

class TwoColors {
  const TwoColors(this.first, this.second);

  final Color first;
  final Color second;
}

class ClassWithList<T> {
  const ClassWithList({required this.list});

  final List<T> list;
}

@Tailor(requireStaticConst: true)
class _$ConstantTheme {
  static const someNumberList = [1, 2];

  static const someClass = [
    Point(x: '', y: ''),
    Point(x: '1:2;3', y: '[1,]2,3'),
  ];

  static const appBarColor = [Colors.green, Colors.grey];

  /// THIS WONT WORK:
  /// For passing several color / textStyle properties use another ThemeExtension
  /// or a class that takes several color properties
  static const notWorkingColorList = [
    [Colors.green, Colors.grey],
    [Colors.white, Colors.pink],
  ];

  /// THIS WILL WORK BUT:
  /// Preferably for working with Colors and TextThemes, use
  /// ThemeExtension class as its properties will be animated during theme change
  static const workingColorList = [
    TwoColors(Colors.green, Colors.grey),
    TwoColors(Colors.white, Colors.pink),
  ];

  static const nestedLists = [
    [
      ClassWithList(list: ['1', '2', '3'])
    ],
    [
      ClassWithList(
        list: [
          'test',
          '12,;][][)()()[,',
          'test',
        ],
      ),
    ],
  ];
}
