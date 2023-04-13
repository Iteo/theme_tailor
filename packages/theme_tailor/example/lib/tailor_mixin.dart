// ignore_for_file: annotate_overrides

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'tailor_mixin.tailor.dart';

class _CustomColorEncoder extends ThemeEncoder<Color> {
  const _CustomColorEncoder();

  @override
  Color lerp(Color a, Color b, double t) => Color.lerp(a, b, t)!;
}

class _CustomNullColorEncoder extends ThemeEncoder<Color?> {
  const _CustomNullColorEncoder();

  @override
  Color? lerp(Color? a, Color? b, double t) => Color.lerp(a, b, t);
}

const _customNullColorEncoder = _CustomNullColorEncoder();

@TailorMixin()
@_customNullColorEncoder
class MixedTheme1 extends ThemeExtension<MixedTheme1>
    with DiagnosticableTreeMixin, _$MixedTheme1TailorMixin {
  const MixedTheme1({
    required this.foreground,
    required this.textStyle,
    required this.ok,
    this.background,
  });

  final Color? background;

  @_CustomColorEncoder()
  final Color foreground;
  final TextStyle textStyle;
  final MixedTheme2 ok;

  static final some = 'Something ${2 + 2}';
  static const calculations = '4';
}

@TailorMixin()
class MixedTheme2 extends ThemeExtension<MixedTheme2>
    with _$MixedTheme2TailorMixin {
  const MixedTheme2({
    required this.foreground,
  });

  final Color foreground;
}
