class ExtensionTemplate {
  const ExtensionTemplate({
    required this.name,
    required this.target,
    required this.content,
  });

  final String name;
  final String target;
  final String content;

  void writeBuffer(StringBuffer main, StringBuffer contentBuffer) {
    main
      ..write('extension $name on $target {')
      ..write(contentBuffer)
      ..write('}');
  }

  @override
  String toString() {
    return '''extension $name on $target { $content } ''';
  }
}
