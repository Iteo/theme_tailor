import 'package:analyzer/dart/element/element.dart';
import 'package:theme_tailor/src/model/constructor_parameter_type.dart';

extension ParameterElementExtension on ParameterElement {
  CtorParamType get parameterType {
    return isNamed
        ? CtorParamType.named
        : isRequired
            ? CtorParamType.required
            : CtorParamType.optional;
  }
}
