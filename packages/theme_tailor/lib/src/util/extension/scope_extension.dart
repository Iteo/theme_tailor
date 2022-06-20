extension ScopeExtension<T1 extends Object> on T1 {
  T2 let<T2>(T2 Function(T1 it) fun) {
    return fun(this);
  }

  T1 also(T1 Function(T1 it) fun) {
    return fun(this);
  }
}
