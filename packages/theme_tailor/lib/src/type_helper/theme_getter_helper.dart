import 'package:source_gen/source_gen.dart';

import '../model/theme_getter_data.dart';

ThemeGetterData themeGetterDataFromData(ConstantReader dartObject) {
  final value = dartObject.revive().accessor.split('.').last;
  return ThemeGetterData.from(value);
}
