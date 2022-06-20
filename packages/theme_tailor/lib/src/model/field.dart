class Field {
  const Field({
    required this.name,
    required this.typeName,
    required this.implementsThemeExtension,
    required this.isTailorThemeExtension,
  });

  final String name;
  final String typeName;
  final bool implementsThemeExtension;
  final bool isTailorThemeExtension;

  Field copyWith({
    String? name,
    String? typeName,
    bool? implementsThemeExtension,
    bool? isTailorThemeExtension,
  }) {
    return Field(
      name: name ?? this.name,
      typeName: typeName ?? this.typeName,
      implementsThemeExtension:
          implementsThemeExtension ?? this.implementsThemeExtension,
      isTailorThemeExtension:
          isTailorThemeExtension ?? this.isTailorThemeExtension,
    );
  }
}
