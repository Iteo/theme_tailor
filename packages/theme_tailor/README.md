<!-- LINKS -->
[build_runner]: https://pub.dev/packages/build_runner
[theme_tailor]: https://pub.dartlang.org/packages/theme_tailor
[ThemeTailor]: https://pub.dartlang.org/packages/theme_tailor
[theme_tailor_annotation]: https://pub.dartlang.org/packages/theme_tailor_annotation

<!-- Examples -->
[examples_folder]: https://github.com/Iteo/theme_tailor/raw/main/packages/theme_tailor/example/lib

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

# Theme Tailor

Welcome to Theme Tailor, a code generator and theming utility for supercharging Flutter ThemeExtension classes introduced in Flutter 3.0! The generator helps to minimize the required boilerplate code.

# Table of contents
- [Motivation](#motivation)
- [How to use](#how-to-use)
    - [Install](#install)
    - [Add imports and part directive](#add-imports-and-part-directive)
    - [Run the code generator](#run-the-code-generator)
    - [Create Theme class](#create-theme-class)
        - [Change themes quantity and names](#change-themes-quantity-and-names)
        - [Change generated extensions](#change-generated-extensions)
        - [Nesting generated ThemeExtensions, Modular themes && DesignSystems](#nesting-generated-themeextensions-modular-themes--designsystems)
        - [Custom types encoding](#custom-types-encoding)
        - [Serialization](#serialization)


# Motivation
Flutter 3.0 provides a new way of theming applications via ThemeData's theme extensions.
To declare theme extension, we may:
- define a class that extends ThemeData,
- define a constructor and fields,
- implement copy with,
- implement lerp,
- (optionally) override hashCode,
- (optionally) override == operator

In addition to generating themes, we may want to declare utility extensions to access theme properties via an extension on BuildContext or ThemeData that requires additional work.
Implementing this requires lots of additional lines of code and time. 


| Before                | After               |
| --------------------- | ------------------- |
| ![before][img_before] | ![after][img_after] |


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
ThemeTailor is a generator for annotation that generates code in a part file that needs to be specified. Make sure to add the following imports and part directive in the file where you use the annotation.

Make sure to specify the correct file name in a part directive. In the example below, replace 'this_is_a_name_of_your_file' with the file name.

###### this_is_a_name_of_your_file.dart
```dart
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'this_is_a_name_of_your_file.tailor.dart'
```

## Run the code generator
To run the code generator, run the following commands:

```console
flutter run build_runner build --delete-conflicting-outputs
```

## Create Theme class
ThemeTailor will generate ThemeExtension class based on the configuration class you are required to annotate with [theme_tailor_annotation]. Please make sure to name class and theme properties appropriately according to the following rules:
- class name starts with `_$` or `$_` (Recommendation is to use the former, as it ensures that the configuration class is private). If the class name does not contain the required prefix, then the generated class name will append an additional suffix,
- class contains static `List<T>` fields (e.g. "static `List<Color> surface = []`). If no fields exist in the config class, the generator will create an empty ThemeExtension class.

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

The following code snippet defines the "MyTheme" theme extension class.
- "MyTheme" extnds `ThemeExtension<MyTheme>`
- defined class is immutable with final fields
- there is one field 'background' of type Color
- "light" and  "dark" static fields matching the default theme names supplied by [theme_tailor_annotation]
- copy method is created (override of ThemeExtension) with a nullable argument "background" of type "Color"
- lerp method is created (override of ThemeExtension) with the default lerping method for the "Color" type.
- an overwritten "hashCode" method && "==" operator

Additionally [theme_tailor_annotation] by default generates extension on BuildContext
- "MyThemeBuildContextProps" extension on "BuildContext" is generated
- getter on "background" of type "Color" is added directly to "BuildContext"

### Change themes quantity and names
By default,  "@tailor" will generate two themes: "light" and "dark".
To control the names and quantity of the themes, edit the "themes" property on the "@Tailor" annotation.

```dart
@Tailor(themes: ['baseTheme'])
class _$MyTheme {}
```

### Accessing generated themes list
The generator will create a static getter with a list of the generated themes:

``` dart
final allThemes = MyTailorGeneratedTheme.themes;
```

### Change generated extensions
By default, "@tailor" will generate an extension on "BuildContext" and expand theme properties as getters. If this is an undesired behavior, you can disable it by changing the "themeGetter" property in the "@Tailor"

```dart
@Tailor(themeGetter: ThemeGetter.none)
```

"ThemeGetter" has several variants for generating common extensions to ease access to the declared themes.

### Nesting generated ThemeExtensions, Modular themes && DesignSystems
It might be beneficial to split them into smaller parts, where each part is responsible for the theme of one component. You can think about it as modularization of the theme. ThemeExtensions allow for easier custom theme integration with Flutter ThemeData without creating additional Inherited widgets handling theme changes. It is especially beneficial when 
- Creating design systems,
- Modularization of the application per feature and components,
- Create a package that supplies widgets and needs more or additional properties not found in ThemeData.

###### NestedThemeExample: Structure of the application's theme data and its extensions. "chatComponentsTheme" has nested properties.
```yaml
ThemeData: [] # Flutter's material widgets props
ThemeDataExtensions:
  - CustomButtonsTheme: [foo, bar]
  - ChatComponentsTheme: 
    - MsgBubble: 
      - Bubble: myBubble
      - Bubble: friendsBubble
    - MsgList: [foo, bar, baz]
```


Use "@tailor" and "@Tailor" annotations if you may need additional extensions on ThemeData or ThemeContext.

Use "@tailorComponent" or "@TailorComponent" if you intend to nest the theme extension class and do not need additional extensions. Use this annotation for generated themes to allow generator to recognize the type correctly. 

```dart
@tailor
class _$ChatComponentsTheme {
  @themeExtension
  static List<MsgBubble> messageTheme = MsgBubble.themes;

  @themeExtension
  static List<MsgList> messageListTheme = MsgList.themes;

  /// "NotGeneratedExtension" is a theme extension that is not created using code generator. It is not necessary to mark it with "@themeExtension" annotation
  static List<NotGeneratedExtension> = [/*custom themes*/]
}

@tailorComponent
class _$MsgBubble {}

/// You can also nest classes marked with @tailor (not recommended)
@tailor
class _$MsgList {}

class NotGeneratedExtension extends ThemeExtension<NotGeneratedExtension> {
  /// implementation
}
```

## Custom types encoding
ThemeTailor will attempt to provide lerp method for types like:
- Color
- Color?
- TextStyle
- TextStyle?

In the case of an unrecognized or unsupported type, the generator provides a default lerping function (That does not interpolate values linearly but switches between them). 
You can specify a custom the lerp function for the given type (Color/TextStyle, etc.) or property by extending "ThemeEncoder" class from [theme_tailor_annotation]

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

Use it in different ways:

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

Generator chooses proper lerp function for the given field based on the order:
- annotation on the field
- annotation on top of the class
- property from encoders list in the "@Tailor" annotation.

Custom supplied encoders override default ones provided by the code generator. Unrecognized or unsupported types will use the default lerp function.

## Flutter diagnosticable
To add support for Flutter diagnosticable to the generated ThemeExtension class, import Flutter foundation.
```dart
import 'package:flutter/foundation.dart';
```

## Serialization
The generator will copy all the annotations on the class and the static fields, including @JsonSerializable @JsonKeys and custom JsonConverter(s) and generate fromJson factory. 

```dart
@tailor
@JsonSerializable()
class _$SerializableTheme {

  /// This is a custom converter
  @JsonColorConverter()
  static List<Color> foo = [Colors.red, Colors.pink];
}
```
