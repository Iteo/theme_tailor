import 'package:theme_tailor/src/util/extension/scope_extension.dart';

abstract class Template {
  const Template();

  void write(StringBuffer buffer);

  @override
  String toString() => StringBuffer().also((it) => write(it)).toString();
}

extension StringBufferExtension on StringBuffer {
  void template(Template template) {
    template.write(this);
    writeln('\n');
  }

  void emptyLine() => writeln('\n');
}
