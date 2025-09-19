import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/auth/rol.dart';

final userRoleProvider = StateProvider<Rol>((ref) => Rol.visitante);

final isAdminProvider = Provider<bool>((ref) {
  final role = ref.watch(userRoleProvider);
  return role == Rol.administrador;
});
