class GetterTemplate {
  const GetterTemplate({
    required this.type,
    required this.name,
    required this.accessor,
  });

  final String type;
  final String name;
  final String accessor;

  void writeBuffer(StringBuffer main) {
    main.writeln([type, ' get ', name, ' => ', accessor, ';']);
  }

  @override
  String toString() {
    return '$name get $name => $accessor;';
  }
}
