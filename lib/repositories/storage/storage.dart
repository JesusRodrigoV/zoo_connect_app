import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';
import 'package:zoo_connect_app/services/storage.dart';

class StorageRepository {
  final StorageService _storageService;

  StorageRepository(this._storageService);

  Future<void> saveUserSession({
    required Usuario usuario,
    required String accessToken,
    required String refreshToken,
  }) async {
    await _storageService.saveUserSession(
      usuario: usuario,
      accessToken: accessToken,
      refreshToken: refreshToken,
    );
  }

  Future<Usuario?> getStoredUser() => _storageService.getStoredUser();

  Future<String?> getAccessToken() => _storageService.getAccessToken();

  Future<String?> getRefreshToken() => _storageService.getRefreshToken();

  Future<bool> isUserLoggedIn() => _storageService.isUserLoggedIn();

  Future<void> clearUserSession() => _storageService.clearUserSession();

  Future<void> updateUserData(Usuario usuario) =>
      _storageService.updateUserData(usuario);

  Future<void> updateAccessToken(String accessToken) =>
      _storageService.updateAccessToken(accessToken);
}

final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  return StorageRepository(StorageService());
});
