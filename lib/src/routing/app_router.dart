import 'package:dresscode/src/pages/home_page.dart';
import 'package:dresscode/src/pages/login_page.dart';
import 'package:dresscode/src/providers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');
  final isAuth = ValueNotifier<AsyncValue<bool>>(const AsyncLoading());

  ref
    ..onDispose(isAuth.dispose)
    // i'm listening only for the isAuthenticated value
    ..listen(
        authControllerProvider.select(
            (value) => value.whenData((value) => value.isAuthenticated)),
        (_, next) {
      isAuth.value = next; // next contains the new value of isAuthenticated
    });

  final router = GoRouter(
    navigatorKey: routerKey,
    refreshListenable: isAuth,
    debugLogDiagnostics: true,
    initialLocation: '/',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      )
    ],
    redirect: (context, state) {
      if (isAuth.value.unwrapPrevious().hasError) return '/login';
      if (isAuth.value.isLoading || !isAuth.value.hasValue) return '/login';

      final auth = isAuth.value.requireValue;

      final isLoggingIn = (state.uri.path == '/login');
      if (isLoggingIn) return auth ? '/' : null;

      return auth ? null : '/login';
    },
  );

  ref.onDispose(router.dispose);

  return router;
}
