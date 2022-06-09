typedef Callback<T> = T Function();

enum ThemeGetterData {
  none,
  onThemeData,
  onThemeDataProps,
  onBuildContext,
  onBuildContextProps;

  factory ThemeGetterData.from(String name) {
    switch (name) {
      case 'onThemeData':
        return ThemeGetterData.onThemeData;
      case 'onThemeDataProps':
        return ThemeGetterData.onThemeDataProps;
      case 'onBuildContext':
        return ThemeGetterData.onBuildContext;
      case 'onBuildContextProps':
        return ThemeGetterData.onBuildContextProps;
      case 'none':
      default:
        return ThemeGetterData.none;
    }
  }

  T maybeWhen<T>({
    required Callback<T> orElse,
    Callback<T>? onThemeData,
    Callback<T>? onThemeDataProps,
    Callback<T>? onBuildContext,
    Callback<T>? onBuildContextProps,
  }) {
    T call(Callback<T>? caller) => caller != null ? caller() : orElse();

    switch (this) {
      case ThemeGetterData.onThemeData:
        return call(onThemeData);
      case ThemeGetterData.onThemeDataProps:
        return call(onThemeDataProps);
      case ThemeGetterData.onBuildContext:
        return call(onBuildContext);
      case ThemeGetterData.onBuildContextProps:
        return call(onBuildContextProps);
      case ThemeGetterData.none:
      default:
        return call(orElse);
    }
  }
}
