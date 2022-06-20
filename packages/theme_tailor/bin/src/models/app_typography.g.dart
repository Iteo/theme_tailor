// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_typography.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppTypography _$AppTypographyFromJson(Map<String, dynamic> json) =>
    AppTypography(
      name: json['name'] as String?,
      fontFamily: json['fontFamily'] as String?,
      description: json['description'] as String?,
      fontSize: json['fontSize'] as int?,
      height: json['lineHeight'] as int?,
      fontStyle: json['fontStyle'] as String?,
      letterSpacing: json['letterSpacing'] as num?,
      fontWeight: json['fontWeight'] as int?,
      decoration: json['textDecoration'] as String?,
    );

Map<String, dynamic> _$AppTypographyToJson(AppTypography instance) =>
    <String, dynamic>{
      'name': instance.name,
      'description': instance.description,
      'fontFamily': instance.fontFamily,
      'fontSize': instance.fontSize,
      'lineHeight': instance.height,
      'fontStyle': instance.fontStyle,
      'letterSpacing': instance.letterSpacing,
      'fontWeight': instance.fontWeight,
      'textDecoration': instance.decoration,
    };
