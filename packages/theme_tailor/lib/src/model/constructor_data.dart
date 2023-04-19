import 'package:theme_tailor/src/model/constructor_parameter_type.dart';

class ConstructorData {
  const ConstructorData({
    required this.constructorName,
    required this.parameterNameToType,
  });

  final String constructorName;
  final Map<String, CtorParamType> parameterNameToType;
}
