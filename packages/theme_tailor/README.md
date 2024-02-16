<!-- LINKS -->
[build_runner]: https://pub.dev/packages/build_runner
[theme_tailor]: https://pub.dartlang.org/packages/theme_tailor
[ThemeTailor]: https://pub.dartlang.org/packages/theme_tailor
[theme_tailor_annotation]: https://pub.dartlang.org/packages/theme_tailor_annotation

[json_serializable_documentation]: https://github.com/google/json_serializable.dart/tree/master/json_serializable#build-configuration

<!-- Examples -->
[example:json_serializable]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/json_serializable_example.dart
[example:theme_encoders]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/json_serializable_example.dart
[example:nested_themes]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/theme_extension_in_field.dart
[example:debug_fill_properties]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/diagnosticable.dart
[example:custom_theme_getter]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/custom_theme_getter.dart
[example:migration_from_tailor_to_tailor_mixin]: https://github.com/Iteo/theme_tailor/blob/main/packages/theme_tailor/example/lib/migration_from_tailor_to_tailor_mixin.dart

<!-- IMAGES -->
[img_before]: https://github.com/Iteo/theme_tailor/raw/main/resources/before.png
[img_after_tailor_mixin]: https://github.com/Iteo/theme_tailor/raw/main/resources/after_tailor_mixin.png

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

<p align="center">
<img src="https://github.com/Iteo/theme_tailor/raw/main/resources/branding/tt-text-logo-transparent.png?raw=true" width="100%" alt="Theme Tailor" />
</p>

Welcome to Theme Tailor, a code generator and theming utility for supercharging Flutter ThemeExtension classes introduced in Flutter 3.0! The generator helps to minimize the required boilerplate code.

# Table of contents
- [Motivation](#motivation)
- [How to use](#how-to-use)
    - [Install](#install)
    - [Add imports and part directive](#add-imports-and-part-directive)
    - [Run the code generator](#run-the-code-generator)
    - [Create Theme class](#create-theme-class)
    - [Change generated extensions](#change-generated-extensions)
    - [Nesting generated theme extensions, modular themes, design systems](#nesting-generated-themeextensions-modular-themes--designsystems)
    - [Custom types encoding](#custom-types-encoding)
    - [Flutter diagnosticable / debugFillProperties](#flutter-diagnosticable--debugfillproperties)
    - [Json serialization](#json-serialization)
    - [Build configuration](#build-configuration)
    - [Custom theme getter](#custom-theme-getter)
    - [Migration from Tailor to TailorMixin](#migration-from-tailor-to-tailormixin)

# Motivation
Flutter 3.0 introduces a new way of theming applications using theme extensions in ThemeData. To declare a theme extension, you need to create a class that extends ThemeData, define its constructor and fields, implement the "copyWith" and "lerp" methods, and optionally override the "hashCode," "==" operator, and implement the "debugFillProperties" method. Additionally you may want to create extensions on BuildContext or ThemeData to access newly created themes. 

All of that involves extra coding work that is time-consuming and error-prone, which is why it is advisable to use a generator.

| No code generation    | @TailorMixin                     |
| --------------------- | -------------------------------- |
| ![before][img_before] | ![after][img_after_tailor_mixin] |

The `@TailorMixin` annotation generates a mixin with an implementation of the ThemeExtension class. It adopts a syntax familiar to standard ThemeExtension classes, allowing for enhanced customization of the resulting class.

*It's worth noting that choosing either the `@Tailor` or `@TailorMixin` generator doesn't restrict you from using the other in the future.
In fact, the two generators can be used together to provide even more flexibility in managing your themes. Ultimately, both generators offer strong solutions for managing themes and can be used interchangeably to provide the level of customization that best suits your project.*

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

Make sure to specify the correct file name in a part directive. In the example below, replace "name" with the file name.

###### name.dart
```dart
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'name.tailor.dart';
```

## Run the code generator
To run the code generator, run the following commands:

```console
flutter run build_runner build --delete-conflicting-outputs
```

## Create Theme class

### @TailorMixin:
Annotate your class with `@TailorMixin()` and mix it with generated mixin, generated mixin name starts with _$ following your class name and ending with "TailorMixin" suffix.

Example
###### my_theme.dart
```dart
import 'package:flutter/material.dart';
import 'package:theme_tailor_annotation/theme_tailor_annotation.dart';

part 'my_theme.tailor.dart';

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme> with _$MyThemeTailorMixin {
  /// You can use required / named / optional parameters in the constructor
  // const MyTheme(this.background);
  // const MyTheme([this.background = Colors.blue])
  const MyTheme({required this.background});
  final Color background;
}
```

The following code snippet defines the "_$MyThemeTailorMixin" theme extension mixin.
- mixin "_$MyThemeTailorMixin" on `ThemeExtension<MyTheme>`
- There is getter "background" field of Color type
- Implements "copyWith" from ThemeExtension, with a nullable argument "background" of type "Color"
- Implements "lerp" from ThemeExtension, with the default lerping method for the "Color" type
- Overrites "hashCode" and "==" operator

Additionally [theme_tailor_annotation] by default generates extension on ThemeData (to change that set themeGetter to ThemeGetter.none or use `@TailorMixinComponent` annotation)
- "MyThemeThemeDataProps" extension on "ThemeData" is generated
- getter on "background" of type "Color" is added directly to "ThemeData"

## Change generated extensions
By default, "@tailorMixin" will generate an extension on "ThemeData" and expand theme properties as getters. If this is an undesired behavior, you can disable it by changing the "themeGetter" property in the "@TailorMixin" or using the "@TailorMixinComponent" annotation.

```dart
@TailorMixin(themeGetter: ThemeGetter.none)
@TailorMixinComponent() // This automatically sets ThemeGetter.none
```

"ThemeGetter" has several variants for generating common extensions to ease access to the declared themes.

## Nesting generated ThemeExtensions, Modular themes && DesignSystems
It might be beneficial to split them into smaller parts, where each part is responsible for the theme of one component. You can think about it as modularization of the theme. ThemeExtensions allow easier custom theme integration with Flutter ThemeData without creating additional Inherited widgets handling theme changes. It is especially beneficial when 
- Creating design systems,
- Modularization of the application per feature and components,
- Create a package that supplies widgets and needs more or additional properties not found in ThemeData.

###### Structure of the application's theme data and its extensions. "chatComponentsTheme" has nested properties.
```yaml
ThemeData: [] # Flutter's material widgets props
ThemeDataExtensions:
  - ChatComponentsTheme: 
    - MsgBubble: 
      - Bubble: myBubble
      - Bubble: friendsBubble
    - MsgList: [foo, bar, baz]
```

Use "@tailorMixin" / "@TailorMixin" annotations if you may need additional extensions on ThemeData or ThemeContext.

Use "@tailorMixinComponent" / "@TailorMixinComponent" if you intend to nest the theme extension class and do not need additional extensions. Use this annotation for generated themes to allow the generator to recognize the type correctly. 

### Example for @TailorMixin annotation:
```dart
@tailorMixin
class ChatComponentsTheme extends ThemeExtension<ChatComponentsTheme> with _$ChatComponentsTheme {
  /// TODO: Implement constructor

  final MsgBubble msgBubble;
  final MsgList msgList;
  final NotGeneratedExtension notGeneratedExtension;
}

@tailorMixinComponent
class MsgBubble extends ThemeExtension<MsgBubble> with _$MsgBubble {
  /// TODO: Implement constructor

  final Bubble myBubble;
  final Bubble friendsBubble;
}

/// The rest of the classes as in the previous example but following @TailorMixin pattern
/// [...]
```

To see an example implementation of a nested theme, head out to [example: nested_themes][example:nested_themes]

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
/// 1 Add it to the encoders list in the @TailorMixin() annotation
@TailorMixin(encoders: [IntEncoder()])
class Theme1 extends ThemeExtension<Theme1> with _$Theme1TailorMixin {}

/// 2 Add it as a separate annotation below @TailorMixin() or @tailorMixin annotation
@tailorMixin
@IntEncoder()
class Theme2 extends ThemeExtension<Theme2> with _$Theme2TailorMixin {}

/// 3 Add it below your custom tailor annotation
const appTailorMixin = TailorMixin(themeGetter: ThemeGetter.onBuildContext);

@appTailorMixin
@IntEncoder()
class Theme3 extends ThemeExtension<Theme3> with _$Theme3TailorMixin {}

/// 4 Add it on the property
@tailorMixin
class Theme4 extends ThemeExtension<Theme4> with _$Theme4TailorMixin {
  // TODO constructor required
    @IntEncoder()
    final Color background;
}

/// 5 IntEncoder() can be assigned to a variable and used as an annotation
/// It works for any of the previous examples
const intEncoder = IntEncoder();

@tailorMixin
@intEncoder
class Theme5 extends ThemeExtension<Theme5> with _$Theme5TailorMixin {}
```

The generator chooses the proper lerp function for the given field based on the order:
- annotation on the field
- annotation on top of the class
- property from encoders list in the "@TailorMixin" annotation.

Custom-supplied encoders override default ones provided by the code generator. Unrecognized or unsupported types will use the default lerp function.

To see more examples of custom theme encoders implementation, head out to [example: theme encoders][example:theme_encoders]

## Flutter diagnosticable / debugFillProperties
To add support for Flutter diagnosticable to the generated ThemeExtension class, import Flutter foundation. Then create the ThemeTailor config class as usual.
```dart
import 'package:flutter/foundation.dart';
```

To see an example of how to ensure debugFillProperties are generated, head out to [example: debugFillProperties][example:debug_fill_properties]

---

For `@TailorMixin()` you also need to mix your class with `DiagnosticableTreeMixin`
```dart
@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme>
    with DiagnosticableTreeMixin, _$MyThemeTailorMixin {
  /// Todo: implement the class
}
```

## Json serialization
The generator will copy all the annotations on the class and the static fields, including: "@JsonSerializable", "@JsonKey", custom JsonConverter(s), and generate the "fromJson" factory. If you wish to add support for the "toJson" method, you can add it in the class extension: 

```dart
class JsonColorConverter implements JsonConverter<Color, int> {
  const JsonColorConverter();
  
  @override
  Color fromJson(int json) => Color(json);

  @override
  int toJson(Color color) => color.value;
}
```

```dart
@tailorMixin
@JsonSerializable()
@JsonColorConverter()
class SerializableTheme extends ThemeExtension<SerializableTheme> with _$SerializableThemeTailorMixin {
  SerializableTheme({
    required this.fooNumber,
    required this.barColor,
  });
  
  factory SerializableTheme.fromJson(Map<String, dynamic> json) =>
          _$SerializableThemeFromJson(json);
  
  @JsonKey(defaultValue: 10)
  final int fooNumber;

  @JsonKey()
  final Color barColor;

  Map<String, dynamic> toJson() => _$SerializableThemeToJson(this);
}
```
To see an example implementation of "@JsonColorConverter" check out [example: json serializable][example:json_serializable]

To serialize nested themes, declare your config classes as presented in the [Nesting generated theme extensions, modular themes, design systems](#nesting-generated-themeextensions-modular-themes--designsystems). Make sure to use proper json_serializable config either in the annotation on the class or your config "build.yaml" or "pubspec.yaml". For more information about customizing build config for json_serializable head to the [json_serializable documentation][json_serializable_documentation].
```dart
@JsonSerializable(explicitToJson: true)
```

## Build configuration
The generator will use properties from build.yaml or default values for null properties in the @TailorMixin annotation.

| Build option          | Annotation property | Default                | Info                                                                                                                            |
| --------------------- | ------------------- | ---------------------- | ------------------------------------------------------------------------------------------------------------------------------- |
| theme_getter          | themeGetter         | on_build_context_props | <b>String</b> (ThemeGetter.name):<br><br>none \ on_theme_data \ on_theme_data_props \ on_build_context \ on_build_context_props |
| theme_class_name      | themeClassName      | null                   | <b>String</b> For custom Theme if you don't want<br>use Material's Theme. Example: FluentTheme                                  |
| theme_data_class_name | themeDataClassName  | null                   | <b>String</b> For custom ThemeData if you don't want<br>use Material's ThemeData FluentThemeData                                |

### Material's theme_getter
```yaml
targets:
  $default:
    builders:
      theme_tailor:
        options:
          theme_getter: on_build_context_props
```

### Custom theme_getter
If you're not using Material, feel free to modify the theme_getter extension to another option. For instance, you can use it with a different theme, like FluentTheme.

```yaml
targets:
  $default:
    builders:
      theme_tailor:
        options:
          theme_getter: on_build_context_props
          theme_class_name: FluentTheme
          theme_data_class_name: FluentThemeData
```

## Custom theme getter
You can configure `theme_getter` to generate custom theme extension using 2 properties `themeClassName` and `themeDataClassName`.

Remember import your theme class.

```dart
import 'package:your_theme/your_theme.dart';
``` 

- For `ThemeGetter.onBuildContext` and `ThemeGetter.onBuildContextProps` use `themeClassName`

```dart
@TailorMixin(
  themeGetter: ThemeGetter.onBuildContext,
  themeClassName: 'YourTheme'
)
class MyTheme extends ThemeExtension<MyTheme> with _$MyThemeTailorMixin {}

/// The generator will generate an extension:
/// 
/// extension MyThemeBuildContext on BuildContext {
///   MyTheme get myTheme => YourTheme.of(this).extension<MyTheme>()!;
/// }
```

- For `ThemeGetter.onThemeData` and `ThemeGetter.onThemeDataProps` use `themeDataClassName`

```dart
@TailorMixin(
  themeGetter: ThemeGetter.onThemeData,
  themeClassName: 'YourThemeData'
)
class MyTheme extends ThemeExtension<MyTheme> with _$MyThemeTailorMixin {}

/// The generator will generate an extension:
/// 
/// extension MyThemeBuildContext on YourThemeData {
///   MyTheme get myTheme => extension<MyTheme>()!;
/// }
```

You can also change properties globally by adjusting `build.yaml`. Check out [Build configuration](#build-configuration) for more info.

To see an example, head out to [example: custom theme getter][example:custom_theme_getter]

## Migration from Tailor to TailorMixin
Starting from version 2.1.0, the theme_tailor library marks the @Tailor and @TailorComponent annotations as deprecated.

The old theme extension class looked like this:

```dart
part 'my_theme.tailor.dart';

@TailorMixin(
  themes: ['light', 'dark'],
)
class $_MyTheme {
  static const List<Color> background = [AppColors.white, Colors.black];
}

final light = SimpleTheme.light;
final dark = SimpleTheme.dark;
```

After migration, your new theme extension class will look like:

```dart
part 'my_theme.tailor.dart';

@TailorMixin()
class MyTheme extends ThemeExtension<MyTheme> with _$MyThemeTailorMixin {
  MigratedSimpleTheme({required this.background});
  final Color background;
}
/// Create themes manually
final lightMyTheme = MyTheme(background: AppColors.white);
final darkMyTheme = MyTheme(background: AppColors.black);
```

To see an example of how to migrate, head out to [example: migration_example][example:migration_from_tailor_to_tailor_mixin]
