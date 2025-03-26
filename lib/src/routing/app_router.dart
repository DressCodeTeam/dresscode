import 'package:dresscode/src/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
  final listenable = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  // ref
  //   ..onDispose(listenable.dispose);
  //   ..onListen(
  //   ); 
  
  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: listenable,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      )
    ],
  );

  ref.onDispose(router.dispose);

  return router;
}
