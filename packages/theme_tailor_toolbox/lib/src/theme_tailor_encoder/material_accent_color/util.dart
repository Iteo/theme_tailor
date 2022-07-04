import 'package:flutter/material.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/color/util.dart';

MaterialAccentColor? lerpMaterialAccentColor(
  MaterialAccentColor? a,
  MaterialAccentColor? b,
  double t,
) {
  if (b == null) {
    if (a == null) {
      return null;
    }
    return MaterialAccentColor(
      colorAlphaScale(a, 1 - t).value,
      {
        100: colorAlphaScale(a.shade100, 1 - t),
        200: colorAlphaScale(a.shade200, 1 - t),
        400: colorAlphaScale(a.shade400, 1 - t),
        700: colorAlphaScale(a.shade700, 1 - t),
      },
    );
  }
  if (a == null) {
    return MaterialAccentColor(
      colorAlphaScale(b, t).value,
      {
        100: colorAlphaScale(b.shade100, t),
        200: colorAlphaScale(b.shade200, t),
        400: colorAlphaScale(b.shade400, t),
        700: colorAlphaScale(b.shade700, t),
      },
    );
  }

  return MaterialAccentColor(
    Color.lerp(a, b, t)!.value,
    {
      100: Color.lerp(a.shade100, b.shade100, t)!,
      200: Color.lerp(a.shade200, b.shade200, t)!,
      400: Color.lerp(a.shade400, b.shade400, t)!,
      700: Color.lerp(a.shade700, b.shade700, t)!,
    },
  );
}
