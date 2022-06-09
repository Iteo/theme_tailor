import 'package:source_gen/source_gen.dart';

import '../model/theme_getter_data.dart';

ExtensionData themeGetterDataFromData(ConstantReader dartObject) {
  final value = dartObject.revive().accessor.split('.').last;
  return ExtensionData.from(value);
}
