# 1.2.0-dev
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
