import 'package:analyzer/dart/element/element2.dart';
import 'package:theme_tailor/src/model/constructor_parameter_type.dart';

extension ParameterElementExtension on FormalParameterElement {
  CtorParamType get parameterType {
    return isNamed
        ? CtorParamType.named
        : isRequired
            ? CtorParamType.required
            : CtorParamType.optional;
  }
}
