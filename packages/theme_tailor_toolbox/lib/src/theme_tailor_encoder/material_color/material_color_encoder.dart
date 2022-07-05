import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/material_color/util.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/no_lerp_encoder.dart';

const materialColorEncoder = MaterialColorEncoder();
const materialColorEncoderNoLerp = MaterialColorEncoderNoLerp();

class MaterialColorEncoder extends ThemeEncoder<MaterialColor> {
  const MaterialColorEncoder();

  @override
  MaterialColor lerp(MaterialColor a, MaterialColor b, double t) =>
      lerpMaterialColor(a, b, t)!;
}

class MaterialColorEncoderNoLerp extends NoLerpEncoder<MaterialColor> {
  const MaterialColorEncoderNoLerp();
}
