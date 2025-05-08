import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

/// SideEffect type, taking a template parameter T
/// [clear] is a to cancel the ongoing request
/// [mutate] takes a future result and update the class with the result
/// [snapshot] is a variable to capture the state of
/// the operation: loading ? error ? data
typedef SideEffect<T> = ({
  VoidCallback clear,
  ValueSetter<Future<T>> mutate,
  AsyncSnapshot<T?> snapshot,
});

SideEffect<T> useSideEffect<T>({bool preserveState = true}) {
  final effect = useState<Future<T>?>(null);
  final snapshot = useFuture<T?>(effect.value, preserveState: preserveState);

  void clear() => effect.value = null;
  void mutate(Future<T> futureValue) => effect.value = futureValue;

  return (
    clear: clear,
    mutate: mutate,
    snapshot: snapshot,
  );
}

extension AsyncSnapshotExtension<T> on AsyncSnapshot<T?> {
  Widget when({
    required Widget Function() loading,
    required Widget Function(Object error, StackTrace? stackTrace) error,
    required Widget Function(T? data) data,
  }) {
    if (connectionState == ConnectionState.waiting) {
      return loading();
    } else if (hasError) {
      return error(this.error!, stackTrace);
    } else {
      return data(this.data);
    }
  }
}
