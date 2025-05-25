import 'package:dresscode/src/models/user_model.dart';
import 'package:dresscode/src/providers/auth_state.dart';
import 'package:dresscode/src/services/auth_service.dart';
import 'dart:async';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthController extends StateNotifier<AuthState> {
  final AuthService _authService;
  final SharedPreferences _prefs;

  AuthController(this._authService, this._prefs) : super(const AuthState()) {
    // Vérifier si un token existe au démarrage
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    final token = _prefs.getString('auth_token');
    if (token != null) {
      state = state.copyWith(isLoading: true);
      try {
        // Récupérer les informations de l'utilisateur avec le token
        final userData = await _authService.getUserInfo(token);
        final user = User.fromJson(userData);
        
        state = state.copyWith(
          isAuthenticated: true,
          user: user,
          token: token,
          isLoading: false,
        );
      } catch (e) {
        // Token invalide ou expiré
        _prefs.remove('auth_token');
        state = state.copyWith(
          isAuthenticated: false,
          user: null,
          token: null,
          isLoading: false,
          errorMessage: e.toString(),
        );
      }
    }
  }

  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final token = await _authService.login(email, password);
      await _prefs.setString('auth_token', token);
      // final userInfo = await _authService.getUserInfo(token);
      state = state.copyWith(
        isAuthenticated: true,
        token: token,
        //  user: User.fromJson(userInfo),
        isLoading: false,
      );
      return true;

    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  Future<bool> register(String name, String email, String password) async {
    state = state.copyWith(isLoading: true, errorMessage: null);
    
    try {
      final success = await _authService.register(name, email, password);
      if (success) {
        await login(email, password);
        return true;
      }
      return false;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        errorMessage: e.toString(),
      );
      return false;
    }
  }

  void logout() {
    _prefs.remove('auth_token');
    state = const AuthState();
  }

  // Accès aux données courantes
  bool get isAuthenticated => state.isAuthenticated;
  User? get currentUser => state.user;
  String? get token => state.token;
  bool get isLoading => state.isLoading;
  String? get errorMessage => state.errorMessage;
}


/*part 'auth_controller.freezed.dart';
part 'auth_controller.g.dart';

/// Making the class "sealed" prevent extensions outside of this file
/// and allows us to use pattern matching in the UI
@Freezed()
sealed class Auth with _$Auth {
  const factory Auth.signedIn({
    required int id,
    required String displayName,
    required String email,
    required String token,
  }) = SignedIn;

  const Auth._();

  const factory Auth.signedOut() = SignedOut;

  bool get isAuthenticated => switch (this) {
        SignedIn() => true,
        SignedOut() => false,
      };
}

/// A mock of an Authenticated User
const _dummyUser = Auth.signedIn(
  id: -1,
  displayName: 'My Name',
  email: 'My Email',
  token: 'some-updated-secret-auth-token',
);

@riverpod
class AuthController extends _$AuthController {
  late SharedPreferences _sharedPreferences;
  static const _sharedPrefsKey = 'token';

  @override
  Future<Auth> build() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _persistenceRefreshLogic();

    return _loginRecoveryAttempt();
  }

  /// Tries to perform a login with the saved token on the persistent storage.
  /// If _anything_ goes wrong, deletes the internal token and
  /// returns a [User.signedOut].
  Future<Auth> _loginRecoveryAttempt() {
    try {
      final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
      if (savedToken == null) {
        throw const UnauthorizedException('No auth token found');
      }
      return _loginWithToken(savedToken);
    } catch (_, __) {
      _sharedPreferences.remove(_sharedPrefsKey).ignore();
      return Future.value(const Auth.signedOut());
    }
  }

  /// Mock of a request performed on logout.
  Future<void> logout() async {
    await Future<void>.delayed(networkRoundTripTime);
    state = const AsyncData(Auth.signedOut());
  }

  /// Mock of a successful login attempt, which results come from the network.
  Future<void> login(String email, String password) async {
    final result = await Future.delayed(
      networkRoundTripTime,
      () => _dummyUser,
    );
    state = AsyncData(result);
  }

  /// Mock of a login request performed with a saved token.
  /// If such request fails, this method will throw an [UnauthorizedException].
  Future<Auth> _loginWithToken(String token) async {
    final logInAttempt = await Future.delayed(
      networkRoundTripTime,
      () => true,
    );

    if (logInAttempt) return _dummyUser;

    throw const UnauthorizedException('401 Unauthorized');
  }

  void _persistenceRefreshLogic() {
    listenSelf((_, next) {
      if (next.isLoading) return;
      if (next.hasError) {
        _sharedPreferences.remove(_sharedPrefsKey);
        return;
      }

      next.requireValue.map<void>(
        signedIn: (signedIn) =>
            _sharedPreferences.setString(_sharedPrefsKey, signedIn.token),
        signedOut: (signedOut) {
          _sharedPreferences.remove(_sharedPrefsKey);
        },
      );
    });
  }
}

/// Simple mock of a 401 exception
class UnauthorizedException implements Exception {
  const UnauthorizedException(this.message);
  final String message;
}

/// Mock of the duration of a network request
final networkRoundTripTime = 2.seconds;
*/