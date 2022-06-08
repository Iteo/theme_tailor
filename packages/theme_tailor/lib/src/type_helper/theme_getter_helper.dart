import 'package:source_gen/source_gen.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

ThemeGetter themeGetterFromData(ConstantReader dartObject) {
  final value = dartObject.revive().accessor;
  return ThemeGetter.values.firstWhere((e) => e.toString() == value);
}
