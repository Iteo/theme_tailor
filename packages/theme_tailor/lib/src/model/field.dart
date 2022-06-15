import 'package:analyzer/dart/element/type.dart';

class Field {
  const Field(this.name, this._type, {this.annotations = const []});

  final String name;
  final DartType _type;
  final List<String> annotations;

  String get typeStr => _type.getDisplayString(withNullability: true);
}
