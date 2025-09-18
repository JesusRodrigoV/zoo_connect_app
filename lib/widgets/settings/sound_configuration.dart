import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/settings/sound_provider.dart';

class SoundConfiguration extends ConsumerWidget {
  const SoundConfiguration({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isSoundEnabled = ref.watch(soundProvider);
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(Icons.volume_up, color: colors.onSurface),
            const SizedBox(width: 10),
            Text(
              'Configuración de Sonido',
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
          child: ListTile(
            title: const Text('Sonido de Feedback'),
            trailing: Switch(
              value: isSoundEnabled,
              onChanged: (bool newValue) {
                ref.read(soundProvider.notifier).setSound(newValue);
              },
            ),
          ),
        ),
      ],
    );
  }
}
