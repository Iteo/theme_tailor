extension ScopeExtension<T extends Object> on T {
  T2 let<T2>(T2 Function(T it) fun) {
    return fun(this);
  }

  T also(void Function(T it) fun) {
    fun(this);
    return this;
  }
}
