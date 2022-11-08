class GetterTemplate {
  const GetterTemplate({
    required this.type,
    required this.name,
    required this.accessor,
    this.documentationComment,
  });

  final String type;
  final String name;
  final String accessor;
  final String? documentationComment;

  @override
  String toString() => documentationComment != null
      ? '$documentationComment\n$type get $name => $accessor;'
      : '$type get $name => $accessor;';
}
