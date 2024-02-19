// ignore_for_file: annotate_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'nullable_params.tailor.dart';

@tailorMixin
class NullableParams extends ThemeExtension<NullableParams> with _$NullableParamsTailorMixin {
  NullableParams({
    required this.background,
    this.appBar,
  });

  final Color background;
  final Color? appBar;
}

final nullableParams = NullableParams(
  background: Colors.black,
);

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme> with DiagnosticableTreeMixin, _$MyThemeTailorMixin {
  MyTheme(this.iconColor);

  final Color iconColor;
}
