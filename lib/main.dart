
import 'package:dresscode/app.dart';
import 'package:dresscode/src/utils/state_logger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

void main() {
  runApp(
    ProviderScope(
      observers: [StateLogger()],
      child: App(),
    ),
  );
}