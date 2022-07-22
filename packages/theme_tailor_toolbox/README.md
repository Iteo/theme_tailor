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
- [How to use](#how-to-use)
    - [Install](#install)
    - [Add imports and part directive](#add-imports-and-part-directive)
- [Encoders](#encoders)

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
@tailor
@NoLerpEncoder<Color>
@NoLerpEncoder<Color?>
class _OnlyLerpFoo {
    @ColorEncoder()
    static const List<Color> foo = [Colors.orange, Colors.blue];
    static const List<Color> bar = [Colors.pink, Colors.red];

    @ColorNullableEncoder()
    static const List<Color?> fooNullable = [Colors.orange, Colors.blue];
    static const List<Color?> barNullable = [Colors.pink, Colors.red];
}

/// Example of a class that disallows interpolation of selected fields
/// (foo and fooNullable will not animate during theme changes)
@tailor
class _DontLerpFoo {
    @NoLerpEncoder<Color>()
    static const List<Color> foo = [Colors.orange, Colors.blue];
    static const List<Color> bar = [Colors.pink, Colors.red];

    @NoLerpEncoder<Color?>()
    static const List<Color?> fooNullable = [Colors.orange, Colors.blue];
    static const List<Color?> barNullable = [Colors.pink, Colors.red];
}
```

Alternatively with EncoderToolbox:
```dart
/// Example of a class that only allows interpolation of selected fields
/// Disabling interpolation provided by default for types like Color
/// (Only foo and fooNullable will animate during theme changes)
@tailor
@EncoderToolbox.colorNoLerp
@EncoderToolbox.colorNullableNoLerp
class _OnlyLerpFoo {
    @EncoderToolbox.colorLerp
    static const List<Color> foo = [Colors.orange, Colors.blue];
    static const List<Color> bar = [Colors.pink, Colors.red];

    @EncoderToolbox.colorNullableLerp
    static const List<Color?> fooNullable = [Colors.orange, Colors.blue];
    static const List<Color?> barNullable = [Colors.pink, Colors.red];
}

/// Example of a class that disallows interpolation of selected fields
/// (foo and fooNullable will not animate during theme changes)
@tailor
class _DontLerpFoo {
    @NoLerpEncoder<Color>()
    static const List<Color> foo = [Colors.orange, Colors.blue];
    static const List<Color> bar = [Colors.pink, Colors.red];

    @NoLerpEncoder<Color?>()
    static const List<Color?> fooNullable = [Colors.orange, Colors.blue];
    static const List<Color?> barNullable = [Colors.pink, Colors.red];
}
```

