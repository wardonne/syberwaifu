bool empty<T>(T? value) {
  if (value is String?) {
    return (value ?? '').trim().isEmpty;
  }
  if (value is List?) {
    return value == null || value.isEmpty;
  }
  if (value is Set?) {
    return value == null || value.isEmpty;
  }
  if (value is Map?) {
    return value == null || value.isEmpty;
  }
  return value == null;
}
