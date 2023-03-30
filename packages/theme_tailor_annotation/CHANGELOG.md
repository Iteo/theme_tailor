# 1.0.3-dev
- Add `generateStaticGetters` property to `@Tailor` and `@TailorComponent` which adds support for hot reload for const fields
- `requireStaticConst` is now available for `@TailorComponent`

# 1.0.3
- Build configuration. It is possible to configure `themes` within the build.yaml

# 1.0.2
- Fixed encoder declaration that prevented creating encoders for nullable types

# 1.0.1
- Exports `DeepCollectionEquality` from `collection` package to support `hashCode` and `== operator` overrides

# 1.0.0
- Initial version of theme_tailor_annotation library
