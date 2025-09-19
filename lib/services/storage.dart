import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';

class StorageService {
  static const String _userKey = 'user_data';
  static const String _accessTokenKey = 'access_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _isLoggedInKey = 'is_logged_in';

  Future<void> saveUserSession({
    required Usuario usuario,
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.setString(_userKey, jsonEncode(usuario.toJson())),
      prefs.setString(_accessTokenKey, accessToken),
      prefs.setString(_refreshTokenKey, refreshToken),
      prefs.setBool(_isLoggedInKey, true),
    ]);
  }

  Future<Usuario?> getStoredUser() async {
    final prefs = await SharedPreferences.getInstance();
    final userString = prefs.getString(_userKey);

    if (userString != null) {
      try {
        return Usuario.fromJson(jsonDecode(userString));
      } catch (e) {
        await clearUserSession();
        return null;
      }
    }
    return null;
  }

  Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_accessTokenKey);
  }

  Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  Future<bool> isUserLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  Future<void> clearUserSession() async {
    final prefs = await SharedPreferences.getInstance();

    await Future.wait([
      prefs.remove(_userKey),
      prefs.remove(_accessTokenKey),
      prefs.remove(_refreshTokenKey),
      prefs.remove(_isLoggedInKey),
    ]);
  }

  Future<void> updateUserData(Usuario usuario) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_userKey, jsonEncode(usuario.toJson()));
  }

  Future<void> updateAccessToken(String accessToken) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_accessTokenKey, accessToken);
  }
}
