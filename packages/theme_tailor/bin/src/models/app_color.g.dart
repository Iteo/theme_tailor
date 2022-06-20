// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_color.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppColor _$AppColorFromJson(Map<String, dynamic> json) => AppColor(
      color: json['color'] as String?,
      name: json['name'] as String?,
      parent: json['parent'] as String?,
      description: json['description'] as String?,
      isDark: json['isDark'] as bool? ?? false,
    );

Map<String, dynamic> _$AppColorToJson(AppColor instance) => <String, dynamic>{
      'color': instance.color,
      'name': instance.name,
      'parent': instance.parent,
      'description': instance.description,
      'isDark': instance.isDark,
    };
