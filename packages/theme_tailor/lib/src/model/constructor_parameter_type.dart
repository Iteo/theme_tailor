enum CtorParamType {
  required,
  named,
  optional;

  T when<T>(
    T Function() onRequired,
    T Function() onNamed,
    T Function() onOptional,
  ) {
    switch (this) {
      case CtorParamType.required:
        return onRequired();
      case CtorParamType.named:
        return onNamed();
      case CtorParamType.optional:
        return onOptional();
    }
  }
}
