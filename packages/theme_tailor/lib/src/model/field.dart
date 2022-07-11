class Field {
  const Field({
    required this.name,
    required this.typeName,
    required this.implementsThemeExtension,
    required this.isTailorThemeExtension,
    this.values,
  });

  final String name;
  final String typeName;
  final bool implementsThemeExtension;
  final bool isTailorThemeExtension;
  final List<String>? values;

  bool get isNullable => typeName.contains('?');

  Field copyWith({
    String? name,
    String? typeName,
    bool? implementsThemeExtension,
    bool? isTailorThemeExtension,
    List<String>? values,
  }) {
    return Field(
      name: name ?? this.name,
      typeName: typeName ?? this.typeName,
      implementsThemeExtension:
          implementsThemeExtension ?? this.implementsThemeExtension,
      isTailorThemeExtension:
          isTailorThemeExtension ?? this.isTailorThemeExtension,
      values: values ?? this.values,
    );
  }
}
