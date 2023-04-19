enum CtorParamType {
  required,
  named,
  optional;

  T when<T>({
    required T Function() onRequired,
    required T Function() onNamed,
    required T Function() onOptional,
  }) {
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
