import 'package:dresscode/src/constants/metadata.dart';
import 'package:dresscode/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class App extends ConsumerWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      title: AppInfos.appName,
      routerConfig: router,
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
    );
  }
}
