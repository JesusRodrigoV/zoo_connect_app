import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';

/// Widget que muestra el nombre del usuario actual
class UserNameDisplay extends ConsumerWidget {
  final TextStyle? style;
  final String fallback;

  const UserNameDisplay({super.key, this.style, this.fallback = 'Usuario'});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final username = ref.watch(getNombreUsuarioActualProvider);

    return Text(username ?? fallback, style: style);
  }
}

/// Widget avatar del usuario con fallback
class UserAvatar extends ConsumerWidget {
  final double radius;
  final IconData fallbackIcon;

  const UserAvatar({
    super.key,
    this.radius = 20,
    this.fallbackIcon = Icons.person,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final avatarUrl = ref.watch(getImagenPerfilUsuarioProvider);
    final username = ref.watch(getNombreUsuarioActualProvider);

    if (avatarUrl != null && avatarUrl.isNotEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundImage: NetworkImage(avatarUrl),
        onBackgroundImageError: (_, __) {},
        child: null,
      );
    }

    // Fallback: usar inicial del nombre o icono
    return CircleAvatar(
      radius: radius,
      child: username != null && username.isNotEmpty
          ? Text(
              username[0].toUpperCase(),
              style: TextStyle(fontSize: radius * 0.6),
            )
          : Icon(fallbackIcon, size: radius * 0.8),
    );
  }
}

/// Widget que muestra información completa del usuario
class UserProfileCard extends ConsumerWidget {
  final VoidCallback? onTap;

  const UserProfileCard({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUsuarioActualProvider);
    final isAuthenticated = ref.watch(getEstaAutenticadoProvider);

    if (!isAuthenticated || user == null) {
      return Card(
        child: ListTile(
          leading: const UserAvatar(),
          title: const Text('No autenticado'),
          subtitle: const Text('Inicia sesión para ver tu perfil'),
          onTap: onTap,
        ),
      );
    }

    return Card(
      child: ListTile(
        leading: const UserAvatar(radius: 25),
        title: UserNameDisplay(style: Theme.of(context).textTheme.titleMedium),
        subtitle: Text(user.email),
        trailing: const Icon(Icons.arrow_forward_ios, size: 16),
        onTap: onTap,
      ),
    );
  }
}

/// Widget que muestra el email del usuario
class UserEmailDisplay extends ConsumerWidget {
  final TextStyle? style;

  const UserEmailDisplay({super.key, this.style});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final email = ref.watch(getEmailUsuarioActualProvider);

    if (email == null) {
      return const SizedBox.shrink();
    }

    return Text(email, style: style);
  }
}

/// Widget condicional que solo se muestra si el usuario está autenticado
class AuthenticatedOnly extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;

  const AuthenticatedOnly({super.key, required this.child, this.fallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(getEstaAutenticadoProvider);

    if (isAuthenticated) {
      return child;
    }

    return fallback ?? const SizedBox.shrink();
  }
}

/// Widget condicional que solo se muestra si el usuario NO está autenticado
class UnauthenticatedOnly extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;

  const UnauthenticatedOnly({super.key, required this.child, this.fallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAuthenticated = ref.watch(getEstaAutenticadoProvider);

    if (!isAuthenticated) {
      return child;
    }

    return fallback ?? const SizedBox.shrink();
  }
}

/// Widget que muestra contenido basado en permisos
class PermissionBasedWidget extends ConsumerWidget {
  final String requiredPermission;
  final Widget child;
  final Widget? fallback;

  const PermissionBasedWidget({
    super.key,
    required this.requiredPermission,
    required this.child,
    this.fallback,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final hasPermission = ref.watch(
      getTienePermisoProvider(requiredPermission),
    );

    if (hasPermission) {
      return child;
    }

    return fallback ?? const SizedBox.shrink();
  }
}

/// Widget para mostrar solo a administradores
class AdminOnly extends ConsumerWidget {
  final Widget child;
  final Widget? fallback;

  const AdminOnly({super.key, required this.child, this.fallback});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isAdmin = ref.watch(getEsAdminProvider);

    if (isAdmin) {
      return child;
    }

    return fallback ?? const SizedBox.shrink();
  }
}

/// Drawer header personalizado para el usuario
class UserDrawerHeader extends ConsumerWidget {
  final VoidCallback? onTap;

  const UserDrawerHeader({super.key, this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(getUsuarioActualProvider);
    final isAuthenticated = ref.watch(getEstaAutenticadoProvider);

    return DrawerHeader(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).primaryColor,
            Theme.of(context).primaryColor.withAlpha(100),
          ],
        ),
      ),
      child: GestureDetector(
        onTap: onTap,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const UserAvatar(radius: 35),
            if (isAuthenticated && user != null) ...[
              UserNameDisplay(
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              UserEmailDisplay(
                style: TextStyle(
                  color: Colors.white.withAlpha(70),
                  fontSize: 14,
                ),
              ),
            ] else ...[
              const Text(
                'No autenticado',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                'Toca para iniciar sesión',
                style: TextStyle(
                  color: Colors.white.withAlpha(70),
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
