import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';
import 'package:zoo_connect_app/screens/auth/login.dart';
import 'package:zoo_connect_app/screens/home.dart';

class ProtectedRoute extends ConsumerWidget {
  final Widget child;
  final bool requiresAuth;
  final bool requiresAdmin;

  const ProtectedRoute({
    super.key,
    required this.child,
    this.requiresAuth = true,
    this.requiresAdmin = false,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(getEstaAutenticadoProvider);
    final isAdmin = ref.watch(getEsAdminProvider);

    // Si la ruta no requiere auth pero el usuario está autenticado,
    // redirigir al home (evita acceder a login/signup cuando ya está autenticado)
    if (!requiresAuth && isAuthenticated) {
      return const Home();
    }

    // Si la ruta requiere auth y el usuario no está autenticado
    if (requiresAuth && !isAuthenticated) {
      return const LoginScreen();
    }

    // Si la ruta requiere admin y el usuario no es admin
    if (requiresAdmin && !isAdmin) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Acceso Denegado'),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back),
            onPressed: () => Navigator.pop(context),
          ),
        ),
        body: const Center(
          child: Text(
            'No tienes permisos para acceder a esta página',
            style: TextStyle(fontSize: 18),
          ),
        ),
      );
    }

    // Si todas las validaciones pasan, mostrar la ruta solicitada
    return child;
  }
}
