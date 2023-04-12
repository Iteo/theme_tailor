class TailorMixinConfig {
  TailorMixinConfig({
    required this.className,
    required this.fields,
  });

  final String className;
  final List<TailorMixinField> fields;
}

class TailorMixinField {
  TailorMixinField({
    required this.type,
    required this.name,
  });

  final String type;
  final String name;
}
