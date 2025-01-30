// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

/// @nodoc
MaterialColor? lerpMaterialColor(MaterialColor? a, MaterialColor? b, double t) {
  if (a == null && b == null) return null;

  final MaterialColor first = a ?? b!;
  final MaterialColor second = b ?? a!;

  return MaterialColor(
    Color.lerp(first, second, t)!.value,
    {
      50: Color.lerp(first.shade50, second.shade50, t)!,
      100: Color.lerp(first.shade100, second.shade100, t)!,
      200: Color.lerp(first.shade200, second.shade200, t)!,
      300: Color.lerp(first.shade300, second.shade300, t)!,
      400: Color.lerp(first.shade400, second.shade400, t)!,
      500: Color.lerp(first.shade500, second.shade500, t)!,
      600: Color.lerp(first.shade600, second.shade600, t)!,
      700: Color.lerp(first.shade700, second.shade700, t)!,
      800: Color.lerp(first.shade800, second.shade800, t)!,
      900: Color.lerp(first.shade900, second.shade900, t)!,
    },
  );
}

/// @nodoc
MaterialAccentColor? lerpMaterialAccentColor(
  MaterialAccentColor? a,
  MaterialAccentColor? b,
  double t,
) {
  if (a == null && b == null) return null;

  final MaterialAccentColor first = a ?? b!;
  final MaterialAccentColor second = b ?? a!;

  return MaterialAccentColor(
    Color.lerp(first, second, t)!.value,
    {
      100: Color.lerp(first.shade100, second.shade100, t)!,
      200: Color.lerp(first.shade200, second.shade200, t)!,
      400: Color.lerp(first.shade400, second.shade400, t)!,
      700: Color.lerp(first.shade700, second.shade700, t)!,
    },
  );
}
