import 'package:example/integration/global_no_lerp_single_lerps.dart'
    as toolbox;
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:theme_tailor_toolbox/src/theme_tailor_encoder/material_color_encoder.dart';

void main() {
  const color1 = Colors.black;
  const color2 = Colors.white;
  const materialColor1 = Colors.orange;
  const materialColor2 = Colors.blue;
  const materialAColor1 = Colors.orangeAccent;
  const materialAColor2 = Colors.blueAccent;

  const theme1 = toolbox.Theme(
    color: color1,
    colorNoLerp: color1,
    materialColor: materialColor1,
    materialColorNoLerp: materialColor1,
    materialAccentColor: materialAColor1,
    materialAccentColorNoLerp: materialAColor1,
  );

  const theme2 = toolbox.Theme(
    color: color2,
    colorNoLerp: color2,
    materialColor: materialColor2,
    materialColorNoLerp: materialColor2,
    materialAccentColor: materialAColor2,
    materialAccentColorNoLerp: materialAColor2,
  );

  test('Proper encoder is called per field / class', () {
    final t = 0.6;

    final themeExpectedLerp = toolbox.Theme(
      color: Color.lerp(theme1.color, theme2.color, t)!,
      colorNoLerp: theme2.colorNoLerp,
      materialColor:
          lerpMaterialColor(theme1.materialColor, theme2.materialColor, t)!,
      materialColorNoLerp: theme2.materialColor,
      materialAccentColor: lerpMaterialAccentColor(
          theme1.materialAccentColor, theme2.materialAccentColor, t)!,
      materialAccentColorNoLerp: theme2.materialAccentColor,
    );

    expect(theme1.lerp(theme2, t), themeExpectedLerp);
  });
}
