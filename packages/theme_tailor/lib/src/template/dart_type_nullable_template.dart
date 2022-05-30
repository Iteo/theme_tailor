import 'template.dart';

class DartTypeNullableTemplate extends Template {
  const DartTypeNullableTemplate(this.type);

  final String type;

  bool get isNullable => type.endsWith('?');

  @override
  String generate() => isNullable ? type : '$type?';
}
