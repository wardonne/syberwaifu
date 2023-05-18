class Arr {
  Arr._();

  static T? tryGet<T>(Map map, key, [T? Function(T? value)? callback]) {
    final value = map[key] as T?;
    return callback != null ? callback(value) : value;
  }

  static T get<T>(Map map, key, [T Function(T value)? callback]) {
    final value = map[key] as T;
    return callback != null ? callback(value) : value;
  }

  static R? tryGetCast<T, R>(Map map, key, R? Function(T? value) callback) {
    return callback(map[key] as T?);
  }

  static R getCast<T, R>(Map map, key, R Function(T value) callback) {
    return callback(map[key] as T);
  }
}
