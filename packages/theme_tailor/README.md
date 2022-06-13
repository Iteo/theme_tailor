<!-- LINKS -->
[build_runner]: https://pub.dev/packages/build_runner
[theme_tailor]: https://pub.dartlang.org/packages/theme_tailor
[ThemeTailor]: https://pub.dartlang.org/packages/theme_tailor
[theme_tailor_annotation]: https://pub.dartlang.org/packages/theme_tailor_annotation


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

Welcome to Theme Tailor, theming utility for generating Flutter ThemeExtension classes and application themes.

# Motivation
Flutter 3.0 provides new way of theming applications via ThemeData's theme extensions.
To declara ThemeExtension we have to:
- define class that extends ThemeData,
- define a constructor and fields,
- implement copyWith,
- implement lerp.

Implementing all of this thakes a lof of lines of code and might be error-prone.

In addition to generating themes we may want to declare utility extensions to access theme properties via extension on BuildContext or ThemeData.
If we wish to access these properties directly (not via the theme class) it requires additional work.

| Before                          | After                          |
| ------------------------------- | ------------------------------ |
| ![before](resources/before.png) | ![after](resources/after.png) |

# Index
- [Motivation](#motivation)
- [Index](#index)
- [How to use](#how-to-use)
    - [Install](#install)
    - [Add imports and part directive](#add-imports-and-part-directive)
    - [Run the code generator](#run-the-code-generator)
    - [Create Theme class](#create-theme-class)
        - [Change themes quantity and names](#change-themes-quantity-and-names)
        - [Change generated extensions](#change-generated-extensions)




# How to use
## Install
ThemeTailor is a code generator and requires [build_runner] to run.
Make sure to add these packages to the project dependencies:
- [build_runner] tool to run code generators (dev dependency)
- [theme_tailor] this package - theming utility (dev dependency)
- [theme_tailor_annotation] annotations for [theme_tailor]


```console
flutter pub add --dev build_runner
flutter pub add --dev theme_tailor
flutter pub add theme_tailor_annotation
```

## Add imports and part directive
ThemeTailor is a generator for annotation, it will generate code in a part file that needs to be specified. Make sure to add following imports and part directive in the file where you use the annotation.

Make sure to speficy correct file name in a part directive. In an example below, replace 'this_is_a_name_of_your_file' with the name of the file.

###### this_is_a_name_of_your_file.dart
```dart
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'this_is_a_name_of_your_file.tailor.dart'
```

## Run the code generator
To run the code generator, run following commands:

```console
flutter run build_runner build --delete-conflicting-outputs
```

## Create Theme class
ThemeTailor will generate ThemeExtension class based on the configuration class that you are required to annotate with [theme_tailor_annotation]. Following conditions must be met:
- class name starts with "`_$`" or "`$_`". The former is recommended as it ensures that the configuration class is private. If class name does not contain required prefix, additional suffix to the class name may be added,
- class contains static `List<T>` fields (e.g. "static `List<Color> surface = []`). If there are no fields in the config class, empty ThemeExtension class will be generated.

Example
###### my_theme.dart
```dart
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'my_theme.tailor.dart';

@tailor
class _$MyTheme {
  static List<Color> background = [Colors.white, Colors.black];
}
```

The following code snippet defines theme extension class namesd `MyTheme`
- `MyTheme` extnds `ThemeExtension<MyTheme>`
- defined class is immutable with final fields
- there is a one field of type `Color` named `background`
- there are 2 static MyTheme fields: `light` and `dark`. These are default theme names supplied by [theme_tailor_annotation]
- copy method is created (override of ThemeExtension) with nullable argument of type `Color` and name `background`
- lerp method is created (override of ThemeExtension) with default lerping method for type `Color`

Additionally [theme_tailor_annotation] by default generates extension on BuildContext
- `MyThemeBuildContextProps` extension on `BuildContext` is generated
- getter on `background` of type `Color` is added directly to `BuildContext` 

### Change themes quantity and names
By default `@tailor` will generate 2 themes: `light` and `dark`.
Theme names and their quantity can be changed by specyfying `themes` property in the @Tailor() annotation

```dart
@Tailor(themes: ['baseTheme'])
class _$MyTheme {}
```

### Change generated extensions
By default `@tailor` will generate extension on `BuildContext` and expand theme properties as getters. If this is undesired behaviour, it can be disabled completely by changing `themeGetter` property in the @Tailor() annotation

```dart
@Tailor(themeGetter: ThemeGetter.none)
```

`ThemeGetter` has several variants for generating common extensions to ease out access to the declared themes.

## Custom property encoding
ThemeTailor will attempt to provide lerp method for types like:
- Color
- Color?
- TextStyle
- TextStyle?

In the case of unrecognized or unsupported types, default lerping function will be used (It won't use linear interpolation). When encoding custom types is is possible to specyfiy lerping function for provided type or for a single property.
To do so, one must extend `ThemeEncoder` class from [theme_tailor_annotation]

Example of adding custom encoder for an int. 
###### my_theme.dart
```dart
import 'dart:ui';

class IntEncoder extends ThemeEncoder<int> {
  const IntEncoder();

  @override
  int lerp(int a, int b, double t) {
    return lerpDouble(a, b, t)!.toInt();
  }
}
```

Then it can be used in several ways:

```dart
/// 1 Add it to the encoders list in the @Tailor() annotation
@Tailor(encoders: [IntEncoder()])
class _$Theme1 {}

/// 2 Add it as a separate annotation below @Tailor() or @tailor annotation
@tailor
@IntEncoder()
class _$Theme2 {}

/// 3 Add it below your custom tailor annotation
const appTailor = Tailor(themes: ['superLight'])

@appTailor
@IntEncoder()
class _$Theme3 {}

/// 4 Add it on the property
@tailor
class _$Theme4 {
    @IntEncoder()
    static const List<int> someValues = [1,2];
}

/// 5 IntEncoder() can be assigned to a variable and used as an annotation
/// It works for any of the previous examples
const intEncoder = IntEncoder();

@tailor
@intEncoder
class _$Theme5 {}
```

Encoder for a given field will be choosen based on the closest annotation related to the field in a following order:
- annotation on the field
- annotation on the class
- property from encoders list in the @Tailor(encoders: []) annotation
- if property has no declared encoders and it it is not one of the default supported ones, default lerp function will be applied
- if encoder is added for one of the supported properties e.g. `Color` this encoder will be used in place of a default one


