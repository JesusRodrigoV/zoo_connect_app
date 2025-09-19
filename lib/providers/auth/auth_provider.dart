import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/auth/auth_state.dart';
import 'package:zoo_connect_app/models/auth/rol.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';
import 'package:zoo_connect_app/providers/auth/auth_notifier.dart';
import 'package:zoo_connect_app/repositories/storage/storage.dart';

/// Provider principal para el estado de autenticación
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  final storageRepository = ref.watch(storageRepositoryProvider);
  return AuthNotifier(storageRepository);
});

/// Provider para obtener el usuario actual (null si no está autenticado)
final getUsuarioActualProvider = Provider<Usuario?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    autenticado: (usuario, _, __) => usuario,
    orElse: () => null,
  );
});

/// Provider para obtener el token de acceso actual
final getTokenAccesoProvider = Provider<String?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    autenticado: (_, accessToken, __) => accessToken,
    orElse: () => null,
  );
});

/// Provider para verificar si el usuario está autenticado
final getEstaAutenticadoProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(
    autenticado: (_, __, ___) => true,
    orElse: () => false,
  );
});

/// Provider para verificar si está cargando
final getEstaCargandoProvider = Provider<bool>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(cargando: () => true, orElse: () => false);
});

/// Provider para obtener el mensaje de error
final getMensajeErrorProvider = Provider<String?>((ref) {
  final authState = ref.watch(authProvider);
  return authState.maybeWhen(error: (mensaje) => mensaje, orElse: () => null);
});

/// Provider para obtener los permisos del usuario actual
final getPermisosUsuarioProvider = Provider<List<String>>((ref) {
  final usuario = ref.watch(getUsuarioActualProvider);
  if (usuario == null) return [];

  // Retornar permisos basados en el rol del usuario
  switch (usuario.rol) {
    case Rol.administrador:
      return ['admin', 'crear', 'editar', 'eliminar', 'ver'];
    case Rol.cuidador:
      return ['crear', 'editar', 'ver'];
    case Rol.veterinario:
      return ['crear', 'ver'];
    case Rol.visitante:
      return ['ver'];
  }
});

/// Provider para obtener el ID del usuario actual
final getIdUsuarioActualProvider = Provider<int?>((ref) {
  final usuario = ref.watch(getUsuarioActualProvider);
  return usuario?.idUsuario;
});

/// Provider para obtener el email del usuario actual
final getEmailUsuarioActualProvider = Provider<String?>((ref) {
  final usuario = ref.watch(getUsuarioActualProvider);
  return usuario?.email;
});

/// Provider para obtener el username del usuario actual
final getNombreUsuarioActualProvider = Provider<String?>((ref) {
  final usuario = ref.watch(getUsuarioActualProvider);
  return usuario?.nombreUsuario;
});

/// Provider para el nombre completo del usuario (si existe)
final getNombreCompletoUsuarioProvider = Provider<String?>((ref) {
  final usuario = ref.watch(getUsuarioActualProvider);
  if (usuario == null) return null;

  return usuario.nombreUsuario;
});

/// Provider para avatar/foto del usuario
final getImagenPerfilUsuarioProvider = Provider<String?>((ref) {
  final usuario = ref.watch(getUsuarioActualProvider);
  return usuario?.fotoUrl;
});

/// Provider para verificar si el usuario es admin
final getEsAdminProvider = Provider<bool>((ref) {
  final permisos = ref.watch(getPermisosUsuarioProvider);
  return permisos.contains('admin');
});

/// Provider family para verificar permisos específicos
final getTienePermisoProvider = Provider.family<bool, String>((ref, permiso) {
  final permisos = ref.watch(getPermisosUsuarioProvider);
  return permisos.contains(permiso);
});
