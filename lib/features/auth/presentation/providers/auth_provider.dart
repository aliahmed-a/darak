import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/providers/core_providers.dart';
import '../../data/auth_api.dart';
import '../../data/auth_repository.dart';
import '../../data/models/app_user.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  return AuthApi(ref.watch(apiClientProvider));
});

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository(ref.watch(authApiProvider), ref.watch(tokenStorageProvider));
});

/// Holds the signed-in resident, or null when signed out. On first read it
/// tries to restore a session from previously stored tokens.
class AuthController extends AsyncNotifier<AppUser?> {
  @override
  Future<AppUser?> build() {
    _wireSessionExpiry();
    return ref.read(authRepositoryProvider).restoreSession();
  }

  /// Connects the shared [ApiClient]'s refresh-failure callback to this
  /// controller so a rejected/expired refresh token signs the user out.
  void _wireSessionExpiry() {
    ref.read(apiClientProvider).onSessionExpired = forceLogout;
  }

  Future<void> login({required String email, required String password}) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(
      () => ref.read(authRepositoryProvider).login(email: email, password: password),
    );
  }

  Future<String> register({required String fullName, required String email, required String password}) {
    return ref.read(authRepositoryProvider).register(fullName: fullName, email: email, password: password);
  }

  Future<void> logout() async {
    await ref.read(authRepositoryProvider).logout();
    state = const AsyncData(null);
  }

  /// Signs the user out locally without calling the server, used when a
  /// refresh token is rejected as invalid/expired.
  void forceLogout() {
    state = const AsyncData(null);
  }
}

final authControllerProvider = AsyncNotifierProvider<AuthController, AppUser?>(
  AuthController.new,
);
