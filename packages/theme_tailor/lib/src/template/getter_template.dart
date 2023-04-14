import 'package:theme_tailor/src/template/template.dart';
import 'package:theme_tailor/src/util/extension/scope_extension.dart';

class GetterTemplate extends Template {
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
  void write(StringBuffer buffer) {
    buffer.write('$_docComment$type get $name => $accessor;');
  }

  String get _docComment {
    return documentationComment?.let((it) => '$it\n') ?? '';
  }
}
