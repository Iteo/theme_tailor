class ExtensionTemplate {
  ExtensionTemplate({
    required this.name,
    required this.target,
    required this.content,
  });

  final String name;
  final String target;
  final String content;

  @override
  String toString() => 'extension $name on $target { $content }';
}
