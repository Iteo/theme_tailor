class Spacing {
  Spacing({
    this.value,
    this.name,
  });

  final double? value;
  final String? name;

  Spacing copyWith({
    double? value,
    String? name,
  }) {
    return Spacing(
      value: value ?? this.value,
      name: name ?? this.name,
    );
  }
}
