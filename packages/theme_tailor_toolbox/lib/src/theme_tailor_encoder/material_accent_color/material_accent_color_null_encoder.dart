import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/material_accent_color/util.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/no_lerp_encoder.dart';

const materialAccentColorNullEncoder = MaterialAccentColorNullEncoder();
const materialAccentColorNullEncoderNoLerp =
    MaterialAccentColorNullEncoderNoLerp();

class MaterialAccentColorNullEncoder
    extends ThemeEncoder<MaterialAccentColor?> {
  const MaterialAccentColorNullEncoder();

  @override
  MaterialAccentColor? lerp(
      MaterialAccentColor? a, MaterialAccentColor? b, double t) {
    return lerpMaterialAccentColor(a, b, t);
  }
}

class MaterialAccentColorNullEncoderNoLerp
    extends NoLerpEncoder<MaterialAccentColor?> {
  const MaterialAccentColorNullEncoderNoLerp();
}
