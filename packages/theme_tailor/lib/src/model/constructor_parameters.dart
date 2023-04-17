class ConstructorData {
  const ConstructorData({
    required this.constructorName,
    required this.parameterNameToType,
  });

  final String constructorName;
  final Map<String, ParameterType> parameterNameToType;
}

enum ParameterType {
  required,
  named,
  optional;

  T when<T>(
    T Function() onRequired,
    T Function() onNamed,
    T Function() onOptional,
  ) {
    switch (this) {
      case ParameterType.required:
        return onRequired();
      case ParameterType.named:
        return onNamed();
      case ParameterType.optional:
        return onOptional();
    }
  }
}
