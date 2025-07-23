# 3.1.0
- Support build 3.0.0.
- Support source_gen 3.0.0.
- Require Dart 3.8.0
- Require analyzer >= 7.5.9
- Require meta 1.9.1
- Use the same versioning for other theme_tailor packages

# 3.0.2
- Support analyzer 7.0.0
- Support source_gen 2.0.0
- Require json_annotation ^4.8.0
- Require Dart >=3.0.0

# 3.0.1
- Bump dependencies versions

# 3.0.0
- Remove depricated `@Tailor` / `@TailorComponent` annotation and code adjustment for mixins.
- Added linteo package to the project.

# 2.1.0
- Add `themeClassName` and `themeDataClassName` properties to `@TailorMixin`. This addition provides the flexibility for themeGetters to generate a custom theme getter for the extension.
- Mark `@Tailor` and `@TailorComponent` annotations as deprecated
- Bump dependencies versions

# 2.0.2
- Fix dependencies (Remove pubdev unknown platforms error)

# 2.0.1
- Bump sdk version

# 2.0.0
- Add `@TailorMixin` annotation
- Add `@TailorMixinComponent` annotation

# 1.2.0
- Add `generateStaticGetters` property to `@Tailor` and `@TailorComponent` which adds support for hot reload for const fields
- `requireStaticConst` is now available for `@TailorComponent`
- Changes how `themeGetter` and `requireStaticConst` are handled internally by the generator, now these properties are nullable

# 1.1.1
- Add `requireStaticConst` property to the `@Tailor` the annotation

# 1.0.3
- Build configuration. It is possible to configure `themes` within the build.yaml
- Add `@ignore` annotation

# 1.0.2
- Fixed encoder declaration that prevented creating encoders for nullable types

# 1.0.1
- Exports `DeepCollectionEquality` from `collection` package to support `hashCode` and `== operator` overrides

# 1.0.0
- Initial version of theme_tailor_annotation library
