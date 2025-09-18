import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/widgets/settings/sound_configuration.dart';
import 'package:zoo_connect_app/widgets/settings/theme_configuration.dart';

class SettingsPage extends ConsumerWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Configuracion'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(children: [ThemeConfiguration(), SoundConfiguration()]),
      ),
    );
  }
}
