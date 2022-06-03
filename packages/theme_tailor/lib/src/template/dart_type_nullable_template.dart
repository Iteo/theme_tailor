class NullableTypeTemplate {
  const NullableTypeTemplate(this.type);

  final String type;

  bool get isNullable => type.endsWith('?') || type == 'dynamic';

  @override
  String toString() => isNullable ? type : '$type?';
}
