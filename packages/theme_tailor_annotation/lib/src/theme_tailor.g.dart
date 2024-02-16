// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_tailor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TailorMixin _$TailorMixinFromJson(Map json) => TailorMixin(
      themeGetter:
          $enumDecodeNullable(_$ThemeGetterEnumMap, json['theme_getter']),
      themeClassName: json['theme_class_name'] as String?,
      themeDataClassName: json['theme_data_class_name'] as String?,
    );

const _$ThemeGetterEnumMap = {
  ThemeGetter.none: 'none',
  ThemeGetter.onThemeData: 'on_theme_data',
  ThemeGetter.onThemeDataProps: 'on_theme_data_props',
  ThemeGetter.onBuildContext: 'on_build_context',
  ThemeGetter.onBuildContextProps: 'on_build_context_props',
};
