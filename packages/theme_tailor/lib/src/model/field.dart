import 'package:analyzer/dart/element/type.dart';
import 'package:theme_tailor/src/util/string_util.dart';

class Field {
  const Field({
    required this.name,
    required DartType type,
    required this.isAnotherTailorTheme,
  }) : _type = type;

  final String name;
  final DartType _type;
  final bool isAnotherTailorTheme;

  String get typeStr {
    final typeDisplayString = _type.getDisplayString(withNullability: true);
    if (isAnotherTailorTheme) {
      const stringUtil = StringUtil();
      return stringUtil.formatClassName(typeDisplayString);
    } else {
      return typeDisplayString;
    }
  }
}
