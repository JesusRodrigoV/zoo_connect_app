import 'package:zoo_connect_app/providers/settings/theme_provider.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:zoo_connect_app/screens/auth/bienvenida.dart';
import 'package:zoo_connect_app/screens/auth/login.dart';
import 'package:zoo_connect_app/screens/auth/signup.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:zoo_connect_app/screens/home.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends ConsumerWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      title: 'ZooConnect',
      theme: ThemeData(
        brightness: Brightness.light,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
          brightness: Brightness.dark,
        ),
      ),
      themeMode: themeMode,
      home: Home(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/login': (context) => const LoginScreen(),
        '/signup': (context) => const SignupScreen(),
        '/bienvenida': (context) => const BienvenidaScreen(),
      },
    );
  }
}
