class AppTypography {
  final String name;
  final String? description;
  final String? fontFamily;
  final int? fontSize;
  final int? height;
  final String? fontStyle;
  final int? letterSpacing;
  final int? fontWeight;

  AppTypography({
    required this.name,
    this.fontFamily,
    this.description,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.letterSpacing,
    this.fontWeight,
  });

  AppTypography copyWith({
    String? name,
    String? description,
    String? fontFamily,
    int? fontSize,
    int? height,
    String? fontStyle,
    int? letterSpacing,
    int? fontWeight,
  }) {
    return AppTypography(
      name: name ?? this.name,
      description: description ?? this.description,
      fontFamily: fontFamily ?? this.fontFamily,
      fontSize: fontSize ?? this.fontSize,
      height: height ?? this.height,
      fontStyle: fontStyle ?? this.fontStyle,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      fontWeight: fontWeight ?? this.fontWeight,
    );
  }
}
