class GetterTemplate {
  const GetterTemplate({
    required this.type,
    required this.name,
    required this.accessor,
  });

  final String type;
  final String name;
  final String accessor;

  @override
  String toString() => '$type get $name => $accessor;';
}
