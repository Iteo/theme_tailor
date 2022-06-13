import 'package:analyzer/dart/element/type.dart';
import 'package:theme_tailor/src/util/string_format.dart';

class Field {
  const Field({
    required this.name,
    required DartType type,
    required this.isAnotherTailorTheme,
    required this.isThemeExtension,
    required this.themeExtensionFields,
  }) : _type = type;

  final String name;
  final DartType _type;
  final bool isAnotherTailorTheme;
  final bool isThemeExtension;
  final List<String> themeExtensionFields;

  String get typeStr {
    final typeDisplayString = _type.getDisplayString(withNullability: true);
    if (isAnotherTailorTheme) {
      const stringFormat = StringFormat();
      return stringFormat.themeClassName(typeDisplayString);
    } else {
      return typeDisplayString;
    }
  }
}
