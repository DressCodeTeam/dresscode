T requireField<T>(
  Map<String, dynamic> json,
  String key,
  {String? className}
) {
  final value = json[key];
  final prefix = className != null ? '$className.fromJson' : 'fromJson';

  if (value == null) {
    throw Exception('$prefix.fromJson: $key cannot be null');
  }

  try {
    return value as T;
  } catch (e) {
    throw Exception(
      '$prefix: $key has wrong type. Expected $T, got ${value.runtimeType}'
    );
  }
}
