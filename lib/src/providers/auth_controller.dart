import 'package:dresscode/src/shared/extensions/time_extension.dart';
import 'dart:async';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'auth_controller.freezed.dart';
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
  /// If _anything_ goes wrong, deletes the internal token and returns a [User.signedOut].
  Future<Auth> _loginRecoveryAttempt() {
    try {
      final savedToken = _sharedPreferences.getString(_sharedPrefsKey);
      if (savedToken == null) throw const UnauthorizedException('No auth token found');

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
        signedIn: (signedIn) => _sharedPreferences.setString(_sharedPrefsKey, signedIn.token),
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
