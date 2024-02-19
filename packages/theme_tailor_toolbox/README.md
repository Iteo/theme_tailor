<!-- LINKS -->
[build_runner]: https://pub.dev/packages/build_runner
[theme_tailor]: https://pub.dartlang.org/packages/theme_tailor
[ThemeTailor]: https://pub.dartlang.org/packages/theme_tailor
[theme_tailor_annotation]: https://pub.dartlang.org/packages/theme_tailor_annotation
[theme_tailor_toolbox]: https://pub.dartlang.org/packages/theme_tailor_toolbox

[json_serializable_documentation]: https://github.com/google/json_serializable.dart/tree/master/json_serializable#build-configuration

<!-- Examples -->
[example:json_serializable]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/json_serializable_example.dart
[example:theme_encoders]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/json_serializable_example.dart
[example:nested_themes]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/theme_extension_in_field.dart
[example:debug_fill_properties]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/diagnosticable.dart

<!-- IMAGES -->
[img_before]: https://github.com/Iteo/theme_tailor/raw/main/resources/before.png
[img_after]: https://github.com/Iteo/theme_tailor/raw/main/resources/after.png

<!-- 
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages). 

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages). 
-->

Set of theming utilities and classes that work with and enhance [theme_tailor] code generator.

# Table of contents
- [Table of contents](#table-of-contents)
- [How to use](#how-to-use)
  - [Install](#install)
  - [Add imports and part directive](#add-imports-and-part-directive)
          - [name.dart](#namedart)
  - [Create Theme class](#create-theme-class)
- [Encoders](#encoders)
  - [Lerping encoders](#lerping-encoders)
  - [Non-lerping encoders](#non-lerping-encoders)
  - [Encoder usage](#encoder-usage)

# How to use
## Install
Install following dependencies:
- [build_runner] tool to run code generators (dev dependency)
- [theme_tailor] theme extension class generator (dev dependency)
- [theme_tailor_annotation] annotations for [theme_tailor]
- [theme_tailor_toolbox] this package.


```console
flutter pub add --dev build_runner
flutter pub add --dev theme_tailor
flutter pub add theme_tailor_annotation
```

## Add imports and part directive
###### name.dart
```dart
import 'package:theme_tailor_toolbox/theme_tailor_toolbox.dart';

part 'name.tailor.dart'
```
With Toolbox, it is not necessary to additionaly import [theme_tailor_annotation] or flutter:foundation, as these imports are exported by Toolbox library. Therefore debugFillProperties will be implemented automatically in all Tailor-generated classes.

## Create Theme class
Head on to the [theme_tailor] documentation to check out detailed instruction on how to create theme extension classes.

# Encoders
Theme Tailor Toolbox provides encoders for a few selected types frequently used in theming.
Encoders can either be accessed by specyfic class or static field on `EncoderToolbox`.
Encoders have 2 implementations per type:
- lerping (field animates per theme change)
- nonLerping (field does not animate but changes instantly in the middle of changing theme when t == 0.5)

## Lerping encoders  
Naming convention is following:\
Non-nullable `foo` -> FooEncoder || EncoderToolbox.fooLerp\
Nullable type `Bar?` -> BarNullableEncoder || EncoderToolbox.barNullableLerp

| **`Type`**             | **`Encoder`**                        | **`EncoderToolbox`**                             |
| ---------------------- | ------------------------------------ | ------------------------------------------------ |
| `Color`                | `ColorEncoder`                       | `EncoderToolbox.colorLerp`                       |
| `Color?`               | `ColorNullableEncoder`               | `EncoderToolbox.colorNullableLerp`               |
| `MaterialAccentColor`  | `MaterialAccentColorEncoder`         | `EncoderToolbox.materialAccentColorLerp`         |
| `MaterialAccentColor?` | `MaterialAccentColorNullableEncoder` | `EncoderToolbox.materialAccentColorNullableLerp` |
| `MaterialColor`        | `MaterialColorEncoder`               | `EncoderToolbox.materialColorLerp`               |
| `MaterialColor?`       | `MaterialColorNullableEncoder`       | `EncoderToolbox.materialColorNullableLerp`       |
| `TextStyle`            | `TextStyleEncoder`                   | `EncoderToolbox.textStyleLerp`                   |
| `TextStyle?`           | `TextStyleNullableEncoder`           | `EncoderToolbox.textStyleNullableLerp`           |

## Non-lerping encoders
Naming convention is following (examples):\
Non-nullable `foo` -> `NoLerpEncoder<foo>` || EncoderToolbox.fooNoLerp\
Nullable type `Bar?` -> `NoLerpEncoder<Bar?>` || EncoderToolbox.barNullableLerp

In case of `NoLerpEncoder` it is possible to use it with any type `T` as `NoLerpEncoder<T>`

| **`Type`**             | **`NoLerpEncoder`**                   | **`EncoderToolbox`**                 |
| ---------------------- | ------------------------------------- | ------------------------------------ |
| `Color`                | `NoLerpEncoder<Color>`                | `.colorNoLerp`                       |
| `Color?`               | `NoLerpEncoder<Color?>`               | `.colorNullableNoLerp`               |
| `MaterialAccentColor`  | `NoLerpEncoder<MaterialAccentColor>`  | `.materialAccentColorNoLerp`         |
| `MaterialAccentColor?` | `NoLerpEncoder<MaterialAccentColor?>` | `.materialAccentColorNullableNoLerp` |
| `MaterialColor`        | `NoLerpEncoder<MaterialColor?>`       | `.materialColorNoLerp`               |
| `MaterialColor?`       | `NoLerpEncoder<MaterialColor?>`       | `.materialColorNullableNoLerp`       |
| `TextStyle`            | `NoLerpEncoder<TextStyle?>`           | `.textStyleNoLerp`                   |
| `TextStyle?`           | `NoLerpEncoder<TextStyle?>`           | `.textStyleNullableNoLerp`           |

## Encoder usage
```dart
/// Example of a class that only allows interpolation of selected fields
/// Disabling interpolation provided by default for types like Color
/// (Only foo and fooNullable will animate during theme changes)
@tailorMixin
@NoLerpEncoder<Color>()
@NoLerpEncoder<Color?>()
class _OnlyLerpFoo extends ThemeExtension<_OnlyLerpFoo> with _$_OnlyLerpFooTailorMixin {
    _OnlyLerpFoo({
    required this.foo,
    required this.bar,
    this.fooNullable,
    this.barNullable,
  });

    @ColorEncoder()
    final Color foo;
    final Color bar;
    @ColorNullableEncoder()
    final Color? fooNullable;
    final Color? barNullable;
}

final orangePink = _OnlyLerpFoo(foo: Colors.orange, bar: Colors.pink, fooNullable: Colors.orange, barNullable: Colors.pink);
final blueRed = _OnlyLerpFoo(foo: Colors.blue, bar: Colors.red, fooNullable: Colors.blue, barNullable: Colors.red);

/// Example of a class that disallows interpolation of selected fields
/// (foo and fooNullable will not animate during theme changes)
@tailorMixin
class _DontLerpFoo extends ThemeExtension<_DontLerpFoo> with _$_DontLerpFooTailorMixin {
  _DontLerpFoo({
    required this.foo,
    required this.bar,
    this.fooNullable,
    this.barNullable,
  });

    @NoLerpEncoder<Color>()
    final Color foo;
    final Color bar;
    @NoLerpEncoder<Color?>()
    final Color? fooNullable;
    final Color? barNullable;
}

final orangePink = _DontLerpFoo(foo: Colors.orange, bar: Colors.pink, fooNullable: Colors.orange, barNullable: Colors.pink);
final blueRed = _DontLerpFoo(foo: Colors.blue, bar: Colors.red, fooNullable: Colors.blue, barNullable: Colors.red);

```

Alternatively with EncoderToolbox:
```dart
/// Example of a class that only allows interpolation of selected fields
/// Disabling interpolation provided by default for types like Color
/// (Only foo and fooNullable will animate during theme changes)
@tailorMixin
@EncoderToolbox.colorNoLerp
@EncoderToolbox.colorNullableNoLerp
class _OnlyLerpFoo extends ThemeExtension<_OnlyLerpFoo> with _$_OnlyLerpFooTailorMixin {
    _OnlyLerpFoo({
      required this.foo,
      required this.bar,
      this.fooNullable,
      this.barNullable,
    });

    @EncoderToolbox.colorLerp
    final List<Color> foo;
    final List<Color> bar;
    @EncoderToolbox.colorNullableLerp
    final List<Color?> fooNullable;
    final List<Color?> barNullable;
}

final orangePink = _OnlyLerpFoo(foo: Colors.orange, bar: Colors.pink, fooNullable: Colors.orange, barNullable: Colors.pink);
final blueRed = _OnlyLerpFoo(foo: Colors.blue, bar: Colors.red, fooNullable: Colors.blue, barNullable: Colors.red);

/// Example of a class that disallows interpolation of selected fields
/// (foo and fooNullable will not animate during theme changes)
@tailorMixin
class _DontLerpFoo extends ThemeExtension<_DontLerpFoo> with _$_DontLerpFooTailorMixin {
    _DontLerpFoo({
      required this.foo,
      required this.bar,
      this.fooNullable,
      this.barNullable,
    });

    @NoLerpEncoder<Color>()
    final Color foo;
    final Color bar;
    @NoLerpEncoder<Color?>()
    final Color? fooNullable;
    final Color? barNullable;
}

final orangePink = _DontLerpFoo(foo: Colors.orange, bar: Colors.pink, fooNullable: Colors.orange, barNullable: Colors.pink);
final blueRed = _DontLerpFoo(foo: Colors.blue, bar: Colors.red, fooNullable: Colors.blue, barNullable: Colors.red);
```

