import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';

class LogoutDialog extends ConsumerWidget {
  const LogoutDialog({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AlertDialog(
      title: const Text("Cerrar Sesión"),
      content: const Text("¿Estás seguro que deseas cerrar sesión?"),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text("Cancelar"),
        ),
        FilledButton(
          onPressed: () async {
            await ref.read(authProvider.notifier).logout();
            if (context.mounted) {
              Navigator.of(
                context,
              ).pushNamedAndRemoveUntil('/bienvenida', (route) => false);
            }
          },
          child: const Text("Cerrar Sesión"),
        ),
      ],
    );
  }
}
