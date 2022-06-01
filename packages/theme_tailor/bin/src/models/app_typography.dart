import 'package:json_annotation/json_annotation.dart';

part 'app_typography.g.dart';

@JsonSerializable()
class AppTypography {
  AppTypography({
    this.name,
    this.fontFamily,
    this.description,
    this.fontSize,
    this.height,
    this.fontStyle,
    this.letterSpacing,
    this.fontWeight,
  });

  final String? name;
  final String? description;
  final String? fontFamily;
  final int? fontSize;
  @JsonKey(name: "lineHeight")
  final int? height;
  final String? fontStyle;
  final int? letterSpacing;
  final int? fontWeight;

  factory AppTypography.fromJson(Map<String, dynamic> json) =>
      _$AppTypographyFromJson(json);

  Map<String, dynamic> toJson() => _$AppTypographyToJson(this);

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
