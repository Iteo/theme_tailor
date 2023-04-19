import 'package:analyzer/dart/element/element.dart';

extension ConstructorElementExtension on ConstructorElement {
  bool hasAllParametersNamed(Set<String> params) {
    return params.containsAll(_parameterNames);
  }

  Iterable<String> get _parameterNames => parameters.map((e) => e.name);
}
