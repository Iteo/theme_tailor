import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/material_color/util.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/no_lerp_encoder.dart';

const materialColorNullEncoder = MaterialColorNullEncoder();
const materialColorNullEncoderNoLerp = MaterialColorNullEncoderNoLerp();

class MaterialColorNullEncoder extends ThemeEncoder<MaterialColor?> {
  const MaterialColorNullEncoder();

  @override
  MaterialColor? lerp(MaterialColor? a, MaterialColor? b, double t) =>
      lerpMaterialColor(a, b, t);
}

class MaterialColorNullEncoderNoLerp extends NoLerpEncoder<MaterialColor?> {
  const MaterialColorNullEncoderNoLerp();
}
