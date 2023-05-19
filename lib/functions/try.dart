Future<T?> tryRun<T>(
  Future<T> Function() fn, {
  Future<void> Function(T result)? onSuccess,
  Future<void> Function(Object? error)? onError,
}) async {
  try {
    final result = await fn();
    if (onSuccess != null) {
      await onSuccess(result);
    }
    return result;
  } catch (error) {
    if (onError != null) {
      await onError(error);
    }
  }
  return null;
}

T? tryRunSync<T>(
  T Function() fn, {
  void Function(T result)? onSuccess,
  void Function(Object? error)? onError,
}) {
  try {
    final result = fn();
    if (onSuccess != null) {
      onSuccess(result);
    }
    return result;
  } catch (error) {
    if (onError != null) {
      onError(error);
    }
  }
  return null;
}
