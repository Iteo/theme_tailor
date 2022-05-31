// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'main.dart';

// **************************************************************************
// ThemeTailorGenerator
// **************************************************************************

/// DEBUG PRINT:
/// class name: SuperThemeEnumThemeExtension
/// themes: (light, superLight, dark, superDark)
/// name: themeType
/// encoder: - | type: Null
/// values: [SuperThemeEnum.light, SuperThemeEnum.superLight, SuperThemeEnum.dark, SuperThemeEnum.superDark] | type: (SuperThemeEnum, SuperThemeEnum, SuperThemeEnum, SuperThemeEnum)
/// name: themeType2
/// encoder: SuperThemeEnumEncoder() | type: SuperThemeEnumEncoder
/// values: [SuperThemeEnum.light, SuperThemeEnum.superLight, SuperThemeEnum.dark, SuperThemeEnum.superDark] | type: (SuperThemeEnum, SuperThemeEnum, SuperThemeEnum, SuperThemeEnum)

class SuperThemeEnumThemeExtension
    extends ThemeExtension<SuperThemeEnumThemeExtension> {
  const SuperThemeEnumThemeExtension({
    required this.themeType,
    required this.themeType2,
  });

  final SuperThemeEnum themeType;
  final SuperThemeEnum themeType2;

  static const SuperThemeEnumThemeExtension light =
      SuperThemeEnumThemeExtension(
    themeType: SuperThemeEnum.light,
    themeType2: SuperThemeEnum.light,
  );

  static const SuperThemeEnumThemeExtension superLight =
      SuperThemeEnumThemeExtension(
    themeType: SuperThemeEnum.superLight,
    themeType2: SuperThemeEnum.superLight,
  );

  static const SuperThemeEnumThemeExtension dark = SuperThemeEnumThemeExtension(
    themeType: SuperThemeEnum.dark,
    themeType2: SuperThemeEnum.dark,
  );

  static const SuperThemeEnumThemeExtension superDark =
      SuperThemeEnumThemeExtension(
    themeType: SuperThemeEnum.superDark,
    themeType2: SuperThemeEnum.superDark,
  );

  @override
  ThemeExtension<SuperThemeEnumThemeExtension> copyWith({
    SuperThemeEnum? themeType,
    SuperThemeEnum? themeType2,
  }) {
    return SuperThemeEnumThemeExtension(
      themeType: themeType ?? this.themeType,
      themeType2: themeType2 ?? this.themeType2,
    );
  }

  @override
  ThemeExtension<SuperThemeEnumThemeExtension> lerp(other, t) {
    if (other is! SuperThemeEnumThemeExtension) return this;
    return SuperThemeEnumThemeExtension(
      themeType: simpleLerp(themeType, other.themeType, t),
      themeType2: simpleLerp(themeType2, other.themeType2, t),
    );
  }

  T simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
}

/// DEBUG PRINT:
/// class name: CustomThemeExtensionLightDark2
/// themes: (light, dark)
/// name: h3
/// encoder: TextDataEncoder([AppColors.orange, Colors.yellow]) | type: TextDataEncoder
/// values: [TextData.h3, TextData(defaultColor: AppColors.orange)] | type: (TextData, TextData)
/// name: h4
/// encoder: textDataEncoderBlackWhite | type: TextDataEncoder
/// values: [TextData.h3, TextData(defaultColor: AppColors.blue)] | type: (TextData, TextData)
/// name: luckyNumber
/// encoder: NumerEncoder() | type: NumerEncoder
/// values: [7, 8] | type: (int, int)
/// name: appBar
/// encoder: - | type: Null
/// values: [AppColors.blue, AppColors.orange] | type: (MaterialColor, MaterialColor)

class CustomThemeExtensionLightDark2
    extends ThemeExtension<CustomThemeExtensionLightDark2> {
  const CustomThemeExtensionLightDark2({
    required this.h3,
    required this.h4,
    required this.luckyNumber,
    required this.appBar,
  });

  final TextData h3;
  final TextData h4;
  final int luckyNumber;
  final MaterialColor appBar;

  static const CustomThemeExtensionLightDark2 light =
      CustomThemeExtensionLightDark2(
    h3: TextData.h3,
    h4: TextData.h3,
    luckyNumber: 7,
    appBar: AppColors.blue,
  );

  static const CustomThemeExtensionLightDark2 dark =
      CustomThemeExtensionLightDark2(
    h3: TextData(defaultColor: AppColors.orange),
    h4: TextData(defaultColor: AppColors.blue),
    luckyNumber: 8,
    appBar: AppColors.orange,
  );

  @override
  ThemeExtension<CustomThemeExtensionLightDark2> copyWith({
    TextData? h3,
    TextData? h4,
    int? luckyNumber,
    MaterialColor? appBar,
  }) {
    return CustomThemeExtensionLightDark2(
      h3: h3 ?? this.h3,
      h4: h4 ?? this.h4,
      luckyNumber: luckyNumber ?? this.luckyNumber,
      appBar: appBar ?? this.appBar,
    );
  }

  @override
  ThemeExtension<CustomThemeExtensionLightDark2> lerp(other, t) {
    if (other is! CustomThemeExtensionLightDark2) return this;
    return CustomThemeExtensionLightDark2(
      h3: simpleLerp(h3, other.h3, t),
      h4: simpleLerp(h4, other.h4, t),
      luckyNumber: simpleLerp(luckyNumber, other.luckyNumber, t),
      appBar: simpleLerp(appBar, other.appBar, t),
    );
  }

  T simpleLerp<T>(T a, T b, double t) => t < .5 ? a : b;
}
