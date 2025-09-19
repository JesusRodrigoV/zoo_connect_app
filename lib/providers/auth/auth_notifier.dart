import 'dart:convert';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zoo_connect_app/models/auth/auth_response.dart';
import 'package:zoo_connect_app/models/auth/auth_state.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';
import 'package:zoo_connect_app/repositories/storage/storage.dart';

class AuthNotifier extends StateNotifier<AuthState> {
  final String _baseUrl =
      dotenv.env['BASE_URL'] ?? 'http://localhost:8000/api/v1';

  late final String _authBaseUrl;

  final StorageRepository _storageRepository;

  AuthNotifier(this._storageRepository)
    : super(const AuthState.noAutenticado()) {
    _authBaseUrl = '$_baseUrl/auth';
    _initializeAuth();
  }

  Future<void> _initializeAuth() async {
    state = const AuthState.cargando();

    try {
      final isLoggedIn = await _storageRepository.isUserLoggedIn();

      if (isLoggedIn) {
        final usuario = await _storageRepository.getStoredUser();
        final accessToken = await _storageRepository.getAccessToken();
        final refreshToken = await _storageRepository.getRefreshToken();

        if (usuario != null && accessToken != null && refreshToken != null) {
          final isTokenValid = await _validateToken(accessToken);

          if (isTokenValid) {
            state = AuthState.autenticado(
              usuario: usuario,
              accessToken: accessToken,
              refreshToken: refreshToken,
            );
          } else {
            await _attemptTokenRefresh(refreshToken);
          }
        } else {
          await _clearStorageAndSetUnauthenticated();
        }
      } else {
        state = const AuthState.noAutenticado();
      }
    } catch (e) {
      await _clearStorageAndSetUnauthenticated();
    }
  }

  Future<bool> _validateToken(String accessToken) async {
    try {
      final response = await http.get(
        Uri.parse('$_authBaseUrl/validate'),
        headers: {'Authorization': 'Bearer $accessToken'},
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  Future<void> _attemptTokenRefresh(String refreshToken) async {
    try {
      final response = await http.post(
        Uri.parse('$_authBaseUrl/refresh'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'refresh_token': refreshToken}),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
        final usuario = await _storageRepository.getStoredUser();

        if (usuario != null) {
          // Actualizar tokens en storage
          await _storageRepository.saveUserSession(
            usuario: usuario,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
          );

          state = AuthState.autenticado(
            usuario: usuario,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
          );
        } else {
          await _clearStorageAndSetUnauthenticated();
        }
      } else {
        await _clearStorageAndSetUnauthenticated();
      }
    } catch (e) {
      await _clearStorageAndSetUnauthenticated();
    }
  }

  Future<void> _clearStorageAndSetUnauthenticated() async {
    await _storageRepository.clearUserSession();
    state = const AuthState.noAutenticado();
  }

  Future<void> register(
    String email,
    String nombreUsuario,
    String password,
  ) async {
    state = const AuthState.cargando();

    try {
      final response = await http.post(
        Uri.parse('$_authBaseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "email": email,
          "password": password,
          "username": nombreUsuario,
        }),
      );

      if (response.statusCode == 201) {
        await login(email, password);
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Error en el registro.');
      }
    } catch (e) {
      state = AuthState.error('Error al registrarse: ${e.toString()}');
    }
  }

  Future<void> login(String email, String password) async {
    state = const AuthState.cargando();

    try {
      final response = await http.post(
        Uri.parse('$_authBaseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'email': email, 'password': password}),
      );

      if (response.statusCode == 200) {
        final authResponse = AuthResponse.fromJson(jsonDecode(response.body));

        final responseUser = await http.get(
          Uri.parse('$_authBaseUrl/me'),
          headers: {'Authorization': 'Bearer ${authResponse.accessToken}'},
        );

        if (responseUser.statusCode == 200) {
          final usuario = Usuario.fromJson(jsonDecode(responseUser.body));

          await _storageRepository.saveUserSession(
            usuario: usuario,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
          );

          state = AuthState.autenticado(
            usuario: usuario,
            accessToken: authResponse.accessToken,
            refreshToken: authResponse.refreshToken,
          );
        } else {
          throw Exception('Error al obtener datos del usuario.');
        }
      } else {
        final error = jsonDecode(response.body);
        throw Exception(error['detail'] ?? 'Error al iniciar sesión.');
      }
    } catch (e) {
      state = AuthState.error('Error al iniciar sesión: ${e.toString()}');
    }
  }

  Future<void> logout() async {
    final currentState = state;

    await currentState.maybeWhen(
      autenticado: (usuario, accessToken, refreshToken) async {
        try {
          await http.post(
            Uri.parse('$_authBaseUrl/logout'),
            headers: {
              'Content-Type': 'application/json',
              'Authorization': 'Bearer $accessToken',
            },
            body: jsonEncode({'refresh_token': refreshToken}),
          );
        } catch (e) {
          // Continuar con logout local
        } finally {
          await _storageRepository.clearUserSession();
          state = const AuthState.noAutenticado();
        }
      },
      orElse: () async {
        await _storageRepository.clearUserSession();
        state = const AuthState.noAutenticado();
      },
    );
  }

  Future<void> updateUserData(Usuario updatedUser) async {
    state.maybeWhen(
      autenticado: (usuario, accessToken, refreshToken) async {
        await _storageRepository.updateUserData(updatedUser);
        state = AuthState.autenticado(
          usuario: updatedUser,
          accessToken: accessToken,
          refreshToken: refreshToken,
        );
      },
      orElse: () {},
    );
  }

  String? get currentAccessToken {
    return state.maybeWhen(
      autenticado: (usuario, accessToken, refreshToken) => accessToken,
      orElse: () => null,
    );
  }

  Usuario? get currentUser {
    return state.maybeWhen(
      autenticado: (usuario, accessToken, refreshToken) => usuario,
      orElse: () => null,
    );
  }

  bool get isAuthenticated {
    return state.maybeWhen(
      autenticado: (usuario, accessToken, refreshToken) => true,
      orElse: () => false,
    );
  }
}
