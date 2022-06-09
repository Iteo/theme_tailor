import 'package:analyzer/dart/element/type.dart';

class Field {
  const Field(this.name, this._type);

  final String name;
  final DartType _type;

  String get typeStr => _type.getDisplayString(withNullability: true);
}
