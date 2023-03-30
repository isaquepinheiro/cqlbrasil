final injbr = _Injection();
final Map<Type, dynamic Function(_Injection i)> _injections = {};

class _Injection {
  void register<T>(T Function(_Injection i) func) {
    if (_injections.containsKey(T)) {
      throw Exception('bind alread registed');
    }
    _injections[T] = func;
  }

  void update<T>(T Function(_Injection i) bind) {
    if (!_injections.containsKey(T)) {
      register<T>(bind);
    }
    _injections[T] = bind;
  }

  void clearAll() {
    _injections.clear();
  }

  bool containsKey<T>() {
    return _injections.containsKey(T);
  }

  T call<T>() => get<T>();

  T get<T>() {
    if (_injections.containsKey(T)) {
      return _injections[T]!(this);
    } else {
      throw Exception('injection not found');
    }
  }
}
