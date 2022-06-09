class Template {
  static void extension({
    required StringBuffer writer,
    required StringBuffer contentBuffer,
    required String name,
    required String target,
  }) {
    writer
      ..write('extension $name on $target {')
      ..write(contentBuffer)
      ..write('}');
  }

  static void getter({
    required StringBuffer writer,
    required String type,
    required String name,
    required String accessor,
  }) {
    writer.writeAll([type, ' get ', name, ' => ', accessor, ';']);
  }
}
