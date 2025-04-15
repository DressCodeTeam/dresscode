import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Useful to log state change in our application
class StateLogger extends ProviderObserver {
  const StateLogger();

  @override
  void didUpdateProvider(
    ProviderBase provider,
    Object? previousValue,
    Object? newValue,
    ProviderContainer container,
  ) {
    debugPrint('''
      Provider update: {
        provider: ${provider.name ?? provider.runtimeType},
        oldValue: $previousValue,
        newValue: $newValue
      }
      ''');
  }
}
