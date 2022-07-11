// ignore_for_file: unused_element, unused_field

import 'package:example/diagnosticable_lib.dart';

part 'constant_theme.tailor.dart';

class SomeClass {
  const SomeClass({
    required this.x,
    required this.y,
  });

  final String x;
  final String y;
}

class ClassWithList<T> {
  const ClassWithList({required this.list});

  final List<T> list;
}

@Tailor(requireStaticConst: true)
class _$ConstantTheme {
  static const someNumberList = [1, 2];

  static const someClass = [
    SomeClass(x: '', y: ''),
    SomeClass(x: '1:2;3', y: '[1,]2,3'),
  ];

  static const appBarColor = [Colors.green, Colors.grey];

  static const doubleList = [
    [Colors.green, Colors.grey],
    [Colors.white, Colors.pink],
  ];

  static const doubleListOfClassWithList = [
    [
      ClassWithList(list: [1, 2, 3])
    ],
    [
      ClassWithList(
        list: [
          'test',
          '12,;][][)()()[,',
          'test',
        ],
      )
    ],
  ];
}
