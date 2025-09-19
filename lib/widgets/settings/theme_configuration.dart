import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/settings/theme_provider.dart';

class ThemeConfiguration extends ConsumerWidget {
  const ThemeConfiguration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.palette, color: colors.onSurface),
            const SizedBox(width: 10),
            Text(
              'Tema de la Aplicación',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: colors.onSurface,
              ),
            ),
          ],
        ),
        SizedBox(height: 15),
        Container(
          decoration: BoxDecoration(
            color: colors.surface,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: colors.outlineVariant),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ListTile(
                title: const Text('Tema'),
                trailing: DropdownButton<ThemeMode>(
                  value: themeMode,
                  onChanged: (ThemeMode? nuevoModo) {
                    if (nuevoModo != null) {
                      ref.read(themeProvider.notifier).setTheme(nuevoModo);
                    }
                  },
                  items: const [
                    DropdownMenuItem(
                      value: ThemeMode.light,
                      child: Row(
                        children: [
                          Icon(Icons.wb_sunny, color: Colors.orange),
                          SizedBox(width: 8),
                          Text('Claro'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.dark,
                      child: Row(
                        children: [
                          Icon(Icons.nights_stay, color: Colors.blueGrey),
                          SizedBox(width: 8),
                          Text('Oscuro'),
                        ],
                      ),
                    ),
                    DropdownMenuItem(
                      value: ThemeMode.system,
                      child: Row(
                        children: [
                          Icon(Icons.device_thermostat, color: Colors.grey),
                          SizedBox(width: 8),
                          Text('Sistema'),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
