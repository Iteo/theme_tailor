# 3.1.1
- Support build 3.0.0 and ^4.0.0
- Support source_gen 3.0.0 and ^4.0.0

# 3.1.0
- Support build 3.0.0.
- Support source_gen 3.0.0.
- Require Dart 3.8.0
- Require analyzer >= 7.5.9

# 3.0.3
- Fix `lerp` mixin implementation adding unnecessary type casts

# 3.0.2
- Support analyzer 7.0.0
- Support source_gen 2.0.0
- Require Dart >=3.0.0

# 3.0.1
- Bump dependencies versions

# 3.0.0
- Remove deprecated `@Tailor` / `@TailorComponent` annotation and code adjustment for mixins.
- Added linteo package to the project.

# 2.1.0
- Add `themeClassName` and `themeDataClassName` properties to `@TailorMixin`. This addition provides the flexibility for themeGetters to generate a custom theme getter for the extension.
- Add migration example from `@Tailor` / `@TailorComponent` to `@TailorMixin` / `@TailorMixinComponent`.
- Bump dependencies versions

# 2.0.2
- Fix dependencies (Remove pubdev unknown platforms error)

# 2.0.1
- Support analyzer version from 5.13.0 to ^6.0.0 (thanks @Maatteogekko)
- Bump sdk version
- Fix image links
- Update documentation

# 2.0.0
- Add additional way to generate ThemeExtension classes with `@TailorMixin` / `@TailorMixinComponent` annotation
- Add support for required and optional constructor parameters for classes annotated with `@TailorMixin` or `@TailorComponent`
- Required version of theme_tailor_annotation is 2.0.0

# 1.2.0
- Added `generateStaticGetters` property to `Tailor` and `TailorComponent` to support hot-reload
- Build configuration. It is possible to configure `themeGetter`, `requireStaticConst` and `generateStaticGetters` annotation properties within the build.yaml with: theme_getter and require_static_const (all keys and values for enums are snake_case)
- Required version of theme_tailor_annotation is 1.2.0

# 1.1.2
- Fix: DiagnosticableTreeMixin not being generated if package:flutter/foundation.dart was proceeded by other Flutter import

# 1.1.1
- Update documentation
- Fix: required version of theme_tailor_annotation is 1.1.1

# 1.1.0
- Generate constant themes if possible
- Nullable fields are no longer required in a generated theme constructor
- Theme fields are now ordered alphabetically in generated code
- Update examples and documentation for good / bad practices
- Increase minimum analyzer version to 5.2
- Fix debug fill properties not generated
- Fix the case when some of the properties were generated as dynamic for Flutter types like Color / TextStyle
- Add package logo to the pub.dev

# 1.0.8
- Fix analyzer constraints
- Improve documentation,

# 1.0.7
- Bump analyzer version

# 1.0.6
- Fix compatibility issues with Flutter 3.3.0

# 1.0.5
- Fix generator not loading default theme names if they were not specified in the annotation or build.yaml
- Improve documentation

# 1.0.4
- Build configuration. It is possible to configure `themes` within the build.yaml
- Fix name collision when theme class contains `themes` field
- Fix the bug where the generator could not handle encoders extending generic type encoders
- Empty theme class will now generate with const constructor
- Add support for typedefs

# 1.0.3
- Improve documentation,
- Fix the broken readme link
- Add branding materials

# 1.0.2
- Improve documentation,
- Add support for json_serializable,
- Add support for nested the extension with `@themeExtension` annotation,
- Add support for Flutter's DiagnosticableTreeMixin (debugFillProperties)
- Generated class will overwrite the `hashCode` and `==` operator. The equality operator will deeply compare collections in the class

# 1.0.1
- Fix README.md

# 1.0.0
- Initial version of theme_tailor library
