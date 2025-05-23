import 'package:dresscode/src/pages/home_page.dart';
import 'package:dresscode/src/pages/login_page.dart';
import 'package:dresscode/src/providers/auth_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'app_router.g.dart';

@riverpod
GoRouter goRouter(Ref ref) {
  final routerKey = GlobalKey<NavigatorState>(debugLabel: 'routerKey');

  // Utilisation du provider pour vérifier si l'utilisateur est authentifié
  final isAuthenticated = ref.watch(isAuthenticatedProvider);

  final router = GoRouter(
    navigatorKey: routerKey,
    debugLogDiagnostics: true,
    initialLocation: isAuthenticated ? '/' : '/login',
    routes: [
      GoRoute(
        path: '/',
        builder: (_, __) => const HomePage(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, __) => const LoginPage(),
      ),
    ],
    redirect: (context, state) {
      final isLoggingIn = state.uri.path == '/login';

      // Redirection en fonction de l'état d'authentification
      if (!isAuthenticated && !isLoggingIn) {
        return '/login';
      }

      if (isAuthenticated && isLoggingIn) {
        return '/';
      }

      return null;
    },
  );

  ref.onDispose(router.dispose);

  return router;
}