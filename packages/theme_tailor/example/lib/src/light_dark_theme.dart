// ignore_for_file: unused_element
// TODO(rongix) enable part file generation

import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

class ColorEncoder extends ThemeEncoder<Color> {
  const ColorEncoder();

  @override
  Lerp<Color> get lerp => throw UnimplementedError();

  @override
  Stringify<Color> get stringify => throw UnimplementedError();
}

class AppColors {
  static const Color blue = Colors.blue;
  static const Color orange = Colors.orange;
}

@tailor
@TailorColor('appBar', [AppColors.blue, AppColors.orange])
@TailorText('h1', [TextData(), TextData()])
@TailorProp('appBar', [AppColors.blue, AppColors.orange], encoder: ColorEncoder())
class _$CustomThemeExtensionLightDark {}
