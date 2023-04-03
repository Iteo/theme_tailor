import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class TailorAnnotationData implements Tailor {
  const TailorAnnotationData({
    required this.themes,
    required this.requireStaticConst,
    required this.themeGetter,
  });

  @override
  final List<String> themes;

  @override
  List<ThemeEncoder> get encoders => [];

  @override
  final bool requireStaticConst;

  @override
  final ThemeGetter themeGetter;

  factory TailorAnnotationData.fromJson(Map json) {
    T? get<T>(String name) => json[name] as T?;

    return TailorAnnotationData(
      themes: get<List<dynamic>>('themes')?.map((e) => e as String).toList() ??
          ['light', 'dark'],
      themeGetter: _themeGetterEnumMap[get<String>('theme_getter')] ??
          ThemeGetter.onBuildContextProps,
      requireStaticConst: get<bool>('require_static_const') ?? false,
    );
  }

  static const _themeGetterEnumMap = {
    'none': ThemeGetter.none,
    'on_theme_data': ThemeGetter.onThemeData,
    'on_theme_data_props': ThemeGetter.onThemeDataProps,
    'on_build_context': ThemeGetter.onBuildContext,
    'on_build_context_props': ThemeGetter.onBuildContextProps,
  };
}
