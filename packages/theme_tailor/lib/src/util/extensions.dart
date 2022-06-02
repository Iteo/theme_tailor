extension LetExtension<T extends Object> on T {
  R let<R>(R Function(T it) fun) {
    return fun(this);
  }
}
