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
