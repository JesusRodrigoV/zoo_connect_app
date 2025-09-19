import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';

part 'auth_state.freezed.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState.inicial() = _Inicial;
  const factory AuthState.cargando() = _Cargando;
  const factory AuthState.autenticado({
    required Usuario usuario,
    required String accessToken,
    required String refreshToken,
  }) = _Autenticado;
  const factory AuthState.noAutenticado() = _NoAutenticado;
  const factory AuthState.error(String mensaje) = _Error;
}
