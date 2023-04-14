class Field implements Comparable<Field> {
  const Field({
    required this.name,
    required this.typeName,
    required this.implementsThemeExtension,
    required this.isTailorThemeExtension,
    this.values,
    this.documentationComment,
  });

  final String name;
  final String typeName;
  final bool implementsThemeExtension;
  final bool isTailorThemeExtension;
  final List<String>? values;
  final String? documentationComment;

  bool get isNullable => typeName.contains('?');

  Field copyWith({
    String? name,
    String? typeName,
    bool? implementsThemeExtension,
    bool? isTailorThemeExtension,
    List<String>? values,
    String? documentationComment,
  }) {
    return Field(
      name: name ?? this.name,
      typeName: typeName ?? this.typeName,
      implementsThemeExtension:
          implementsThemeExtension ?? this.implementsThemeExtension,
      isTailorThemeExtension:
          isTailorThemeExtension ?? this.isTailorThemeExtension,
      values: values ?? this.values,
      documentationComment: documentationComment ?? this.documentationComment,
    );
  }

  @override
  int compareTo(Field other) {
    if (isNullable == other.isNullable) return name.compareTo(other.name);
    return isNullable ? 1 : -1;
  }
}
