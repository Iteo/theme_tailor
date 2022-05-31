/// Target for the generated code
/// Just for the reference these are made private. Generated code
/// should have public classes
// ignore_for_file: unused_element, unused_field

part of 'main.dart';

// **************************************************************************
// ThemeTailorGenerator
// **************************************************************************

class _CustomThemeExtensionLightDark2 extends ThemeExtension<_CustomThemeExtensionLightDark2> {
  static const _unnamedTextDataEncoder1 = TextDataEncoder([AppColors.orange, Colors.yellow]);
  static const _unnamedNumerEncoder1 = NumerEncoder();

  // TODO Try to generate class with precomputed properties
  /// Transform data for the themes prior to generating theme extension (not in the file?)
  /// If possible precompute during codegen
  static final _textDataEncoderTransformed = {
    'h3': [
      _unnamedTextDataEncoder1.transformData!(TextData.h3, 0),
      _unnamedTextDataEncoder1.transformData!(const TextData(defaultColor: AppColors.orange), 1),
    ],
    'h4': [
      textDataEncoderBlackWhite.transformData!(TextData.h3, 0),
      textDataEncoderBlackWhite.transformData!(const TextData(defaultColor: AppColors.blue), 1),
    ],
  };

  static final _numerEncoderTransformed = {
    'luckyNumber': [
      _unnamedNumerEncoder1.transformData!(7, 0),
      _unnamedNumerEncoder1.transformData!(8, 1),
    ],
  };

  _CustomThemeExtensionLightDark2({
    required this.h3,
    required this.h4,
    required this.luckyNumber,
    required this.appBar,
  });

  final TextStyle h3;
  final TextStyle h4;
  final double luckyNumber;
  final Color appBar;

  static final _CustomThemeExtensionLightDark2 light = _CustomThemeExtensionLightDark2(
    h3: _textDataEncoderTransformed['h3']![0],
    h4: _textDataEncoderTransformed['h4']![0],
    luckyNumber: _numerEncoderTransformed['luckyNumber']![0],
    appBar: AppColors.blue,
  );

  static final _CustomThemeExtensionLightDark2 dark = _CustomThemeExtensionLightDark2(
    h3: _textDataEncoderTransformed['h3']![1],
    h4: _textDataEncoderTransformed['h4']![1],
    luckyNumber: _numerEncoderTransformed['luckyNumber']![1],
    appBar: AppColors.orange,
  );

  @override
  ThemeExtension<_CustomThemeExtensionLightDark2> copyWith({
    TextStyle? h3,
    TextStyle? h4,
    double? luckyNumber,
    Color? appBar,
  }) {
    return _CustomThemeExtensionLightDark2(
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      luckyNumber: luckyNumber ?? this.luckyNumber,
      appBar: appBar ?? this.appBar,
    );
  }

  @override
  ThemeExtension<_CustomThemeExtensionLightDark2> lerp(
      ThemeExtension<_CustomThemeExtensionLightDark2>? other, double t) {
    if (other is! _CustomThemeExtensionLightDark2) return this;
    return _CustomThemeExtensionLightDark2(
      h3: _unnamedTextDataEncoder1.lerp(h3, other.h3, t),
      h4: textDataEncoderBlackWhite.lerp(h4, other.h4, t),
      luckyNumber: _unnamedNumerEncoder1.lerp(luckyNumber, other.luckyNumber, t),
      appBar: _lerpColor(appBar, other.appBar, t),
    );
  }

  // TODO add encoders for supported types
  /// Some of the types are oficially supported and there is no need to write encoders for them (e.g. [Color])
  Color _lerpColor(Color a, Color b, double t) => Color.fromARGB(
        _lerpColorComponent(a.alpha, b.alpha, t),
        _lerpColorComponent(a.red, b.red, t),
        _lerpColorComponent(a.green, b.green, t),
        _lerpColorComponent(a.blue, b.blue, t),
      );

  int _lerpColorComponent(int a, int b, double t) => _clampInt(_lerpInt(a, b, t), 0, 255);

  double _lerpInt(int a, int b, double t) => a + (b - a) * t;

  int _clampInt(double value, int min, int max) {
    if (value < min) {
      return min;
    } else if (value > max) {
      return max;
    } else {
      return value.toInt();
    }
  }

  // Lerp function for unknown (any) type
  T simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
}
