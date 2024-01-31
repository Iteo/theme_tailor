// ignore_for_file: annotate_overrides

import 'package:fluent_ui/fluent_ui.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'custom_theme_getter.tailor.dart';

@TailorMixin(
  themeGetter: ThemeGetter.onBuildContext,
  themeClassName: 'FluentTheme',
)
class GetterTheme extends ThemeExtension<GetterTheme>
    with _$GetterThemeTailorMixin {
  GetterTheme({
    required this.background,
    required this.appBar,
    required this.cartComponent,
  });

  final Color background;
  final Color appBar;
  final CartComponent cartComponent;

  static const h1Style = TextStyle(fontSize: 15, color: Colors.grey);
  static const h2Style = TextStyle(fontSize: 14, color: Colors.black);
}

@TailorMixinComponent()
class CartComponent extends ThemeExtension<CartComponent>
    with _$CartComponentTailorMixin {
  CartComponent({
    required this.color,
    required this.h2Style,
  });

  final Color color;
  final TextStyle h2Style;
}

/// Usage of theme extension
Map<String, FluentThemeData> themes = {
  'light': FluentThemeData(
    scaffoldBackgroundColor: Colors.white,
    extensions: [
      GetterTheme(
        background: Colors.white,
        appBar: Colors.white,
        cartComponent: CartComponent(
          color: Colors.black,
          h2Style: const TextStyle(color: Colors.white),
        ),
      ),
    ],
  ),
  'dark': FluentThemeData(
    scaffoldBackgroundColor: Colors.black,
    extensions: [
      GetterTheme(
        background: Colors.black,
        appBar: Colors.white,
        cartComponent: CartComponent(
          color: Colors.white,
          h2Style: const TextStyle(color: Colors.black),
        ),
      ),
    ],
  ),
};
