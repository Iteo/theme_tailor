import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

/// ### LinearGradientEncoder
/// The default implementations of the ThemeEncoder for `LinearGradient`
///
/// {@template tttoolbox.encoders.encoderUsage}
/// Each of the encoders handles only one exact type. Encoder type must match
/// the field type.\
/// Use `NoLerpEncoder<T>` to prevent interpolation
/// {@endtemplate}
class LinearGradientEncoder extends ThemeEncoder<LinearGradient> {
  const LinearGradientEncoder();

  @override
  LinearGradient lerp(LinearGradient a, LinearGradient b, double t) => LinearGradient.lerp(a, b, t)!;
}

/// ### LinearGradientNullableEncoder
/// The default implementations of the ThemeEncoder for `LinearGradient?`
///
/// {@macro tttoolbox.encoders.encoderUsage}
class LinearGradientNullableEncoder extends ThemeEncoder<LinearGradient?> {
  const LinearGradientNullableEncoder();

  @override
  LinearGradient? lerp(LinearGradient? a, LinearGradient? b, double t) => LinearGradient.lerp(a, b, t);
}

/// ### SweepGradientEncoder
/// The default implementations of the ThemeEncoder for `SweepGradient`
///
/// {@template tttoolbox.encoders.encoderUsage}
/// Each of the encoders handles only one exact type. Encoder type must match
/// the field type.\
/// Use `NoLerpEncoder<T>` to prevent interpolation
/// {@endtemplate}
class SweepGradientEncoder extends ThemeEncoder<SweepGradient> {
  const SweepGradientEncoder();

  @override
  SweepGradient lerp(SweepGradient a, SweepGradient b, double t) => SweepGradient.lerp(a, b, t)!;
}

/// ### SweepGradientNullableEncoder
/// The default implementations of the ThemeEncoder for `SweepGradient?`
///
/// {@macro tttoolbox.encoders.encoderUsage}
class SweepGradientNullableEncoder extends ThemeEncoder<SweepGradient?> {
  const SweepGradientNullableEncoder();

  @override
  SweepGradient? lerp(SweepGradient? a, SweepGradient? b, double t) => SweepGradient.lerp(a, b, t);
}

/// ### RadialGradientEncoder
/// The default implementations of the ThemeEncoder for `RadialGradient`
///
/// {@template tttoolbox.encoders.encoderUsage}
/// Each of the encoders handles only one exact type. Encoder type must match
/// the field type.\
/// Use `NoLerpEncoder<T>` to prevent interpolation
/// {@endtemplate}
class RadialGradientEncoder extends ThemeEncoder<RadialGradient> {
  const RadialGradientEncoder();

  @override
  RadialGradient lerp(RadialGradient a, RadialGradient b, double t) => RadialGradient.lerp(a, b, t)!;
}

/// ### RadialGradientNullableEncoder
/// The default implementations of the ThemeEncoder for `RadialGradient?`
///
/// {@macro tttoolbox.encoders.encoderUsage}
class RadialGradientNullableEncoder extends ThemeEncoder<RadialGradient?> {
  const RadialGradientNullableEncoder();

  @override
  RadialGradient? lerp(RadialGradient? a, RadialGradient? b, double t) => RadialGradient.lerp(a, b, t);
}
