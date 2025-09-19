import 'package:zoo_connect_app/providers/auth/auth_provider.dart';
import 'package:zoo_connect_app/providers/settings/theme_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zoo_connect_app/config/router/app_router.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    final isAuthenticated = ref.watch(getEstaAutenticadoProvider);

    return MaterialApp(
      title: 'ZooConnect',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
        useMaterial3: true,
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
        useMaterial3: true,
      ),
      themeMode: themeMode,
      initialRoute: isAuthenticated ? '/' : '/bienvenida',
      onGenerateRoute: AppRouter.generateRoute,
      debugShowCheckedModeBanner: false,
    );
  }
}
