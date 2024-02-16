class TailorField extends Field {
  TailorField({
    required super.name,
    required super.type,
    required super.isThemeExtension,
    required this.isTailorThemeExtension,
    super.documentation,
    this.values,
  });

  bool isTailorThemeExtension;
  List<String>? values;
}

class Field implements Comparable<Field> {
  Field({
    required this.name,
    required this.type,
    required this.documentation,
    required this.isThemeExtension,
  });

  String name;
  String type;
  bool isThemeExtension;
  String? documentation;

  bool get isNullable => type.contains('?');
  bool get isDynamic => type == 'dynamic';

  String get typeAsNullable => (isNullable || isDynamic) ? type : '$type?';

  @override
  int compareTo(Field other) {
    if (isNullable == other.isNullable) return name.compareTo(other.name);
    return isNullable ? 1 : -1;
  }
}
