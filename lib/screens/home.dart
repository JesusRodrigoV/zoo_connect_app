import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';
import 'package:zoo_connect_app/screens/home/home_page.dart';
import 'package:zoo_connect_app/screens/quiz/quiz_bienvenida.dart';
import 'package:zoo_connect_app/screens/perfil/perfil.dart';
import 'package:zoo_connect_app/widgets/shared/navigation_bar.dart';

class Home extends ConsumerStatefulWidget {
  const Home({super.key});

  @override
  ConsumerState<Home> createState() => _HomeState();
}

class _HomeState extends ConsumerState<Home> {
  int currentPageIndex = 0;

  Widget inicioPage() {
    return HomePage();
  }

  Widget segundaPagina() {
    return QuizBienvenida();
  }

  Widget terceraPagina() {
    final usuario = ref.watch(getUsuarioActualProvider);

    if (usuario == null) {
      return const Center(child: Text('No has iniciado sesión'));
    }
    return PerfilPage(usuario: usuario);
  }

  void onNavigationDestinationSelected(int index) {
    setState(() {
      currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: <Widget>[
          inicioPage(),
          segundaPagina(),
          terceraPagina(),
        ][currentPageIndex],
      ),
      bottomNavigationBar: ZooNavigationBar(
        selectedIndex: currentPageIndex,
        onDestinationSelected: onNavigationDestinationSelected,
      ),
    );
  }
}
