import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/util/color.dart';

abstract class MaterialColorEncoder {
  const factory MaterialColorEncoder() = MaterialColorEncoderImpl;
  const factory MaterialColorEncoder.nullable() =
      MaterialColorEncoderNullableImpl;
}

class MaterialColorEncoderImpl extends ThemeEncoder<MaterialColor>
    implements MaterialColorEncoder {
  const MaterialColorEncoderImpl();

  @override
  MaterialColor lerp(MaterialColor a, MaterialColor b, double t) =>
      lerpMaterialColor(a, b, t)!;
}

class MaterialColorEncoderNullableImpl extends ThemeEncoder<MaterialColor?>
    implements MaterialColorEncoder {
  const MaterialColorEncoderNullableImpl();

  @override
  MaterialColor? lerp(MaterialColor? a, MaterialColor? b, double t) =>
      lerpMaterialColor(a, b, t);
}

MaterialColor? lerpMaterialColor(MaterialColor? a, MaterialColor? b, double t) {
  if (b == null) {
    if (a == null) {
      return null;
    }
    return MaterialColor(
      colorAlphaScale(a, 1 - t).value,
      {
        50: colorAlphaScale(a.shade50, 1 - t),
        100: colorAlphaScale(a.shade100, 1 - t),
        200: colorAlphaScale(a.shade200, 1 - t),
        300: colorAlphaScale(a.shade300, 1 - t),
        400: colorAlphaScale(a.shade400, 1 - t),
        500: colorAlphaScale(a.shade500, 1 - t),
        600: colorAlphaScale(a.shade600, 1 - t),
        700: colorAlphaScale(a.shade700, 1 - t),
        800: colorAlphaScale(a.shade800, 1 - t),
        900: colorAlphaScale(a.shade900, 1 - t),
      },
    );
  }
  if (a == null) {
    return MaterialColor(
      colorAlphaScale(b, t).value,
      {
        50: colorAlphaScale(b.shade50, t),
        100: colorAlphaScale(b.shade100, t),
        200: colorAlphaScale(b.shade200, t),
        300: colorAlphaScale(b.shade300, t),
        400: colorAlphaScale(b.shade400, t),
        500: colorAlphaScale(b.shade500, t),
        600: colorAlphaScale(b.shade600, t),
        700: colorAlphaScale(b.shade700, t),
        800: colorAlphaScale(b.shade800, t),
        900: colorAlphaScale(b.shade900, t),
      },
    );
  }

  return MaterialColor(
    Color.lerp(a, b, t)!.value,
    {
      50: Color.lerp(a.shade50, b.shade50, t)!,
      100: Color.lerp(a.shade100, b.shade100, t)!,
      200: Color.lerp(a.shade200, b.shade200, t)!,
      300: Color.lerp(a.shade300, b.shade300, t)!,
      400: Color.lerp(a.shade400, b.shade400, t)!,
      500: Color.lerp(a.shade500, b.shade500, t)!,
      600: Color.lerp(a.shade600, b.shade600, t)!,
      700: Color.lerp(a.shade700, b.shade700, t)!,
      800: Color.lerp(a.shade800, b.shade800, t)!,
      900: Color.lerp(a.shade900, b.shade900, t)!,
    },
  );
}
