import 'package:dresscode/src/providers/auth_controller.dart';
import 'package:dresscode/src/providers/auth_state.dart';
import 'package:dresscode/src/services/auth_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

// Provider pour SharedPreferences
final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('Initialisez ce provider dans votre main.dart');
});

// Provider pour AuthService
final authServiceProvider = Provider<AuthService>((ref) {
  return AuthService();
});

// Provider pour AuthController
final authControllerProvider =
    StateNotifierProvider<AuthController, AuthState>((ref) {
  final authService = ref.watch(authServiceProvider);
  final prefs = ref.watch(sharedPreferencesProvider);
  return AuthController(authService, prefs);
});

// Provider pour vérifier si l'utilisateur est authentifié
final isAuthenticatedProvider = Provider<bool>((ref) {
  return ref.watch(authControllerProvider).isAuthenticated;
});

// Provider pour obtenir l'utilisateur actuel
final currentUserProvider = Provider((ref) {
  return ref.watch(authControllerProvider).user;
});

// Provider pour obtenir le token d'authentification
final authTokenProvider = Provider<String?>((ref) {
  return ref.watch(authControllerProvider).token;
});
