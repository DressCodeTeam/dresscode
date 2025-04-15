import 'package:dresscode/app.dart';
import 'package:dresscode/src/utils/state_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() {
  runApp(
    const ProviderScope(
      observers: [StateLogger()],
      child: App(),
    ),
  );
}
