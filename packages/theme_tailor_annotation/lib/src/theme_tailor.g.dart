// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_tailor.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Tailor _$TailorFromJson(Map json) => Tailor(
      themes:
          (json['themes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      themeGetter:
          $enumDecodeNullable(_$ThemeGetterEnumMap, json['theme_getter']),
      requireStaticConst: json['require_static_const'] as bool?,
      generateStaticGetters: json['generate_static_getters'] as bool? ?? true,
    );

const _$ThemeGetterEnumMap = {
  ThemeGetter.none: 'none',
  ThemeGetter.onThemeData: 'on_theme_data',
  ThemeGetter.onThemeDataProps: 'on_theme_data_props',
  ThemeGetter.onBuildContext: 'on_build_context',
  ThemeGetter.onBuildContextProps: 'on_build_context_props',
};
