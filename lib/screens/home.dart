import 'package:flutter/material.dart';
import 'package:zoo_connect_app/screens/home/home_page.dart';
import 'package:zoo_connect_app/screens/quiz/quiz_bienvenida.dart';
import 'package:zoo_connect_app/screens/perfil/perfil.dart';
import 'package:zoo_connect_app/widgets/shared/navigation_bar.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  Widget homePage() {
    return HomePage();
  }

  Widget segundaPagina() {
    return QuizBienvenida();
  }

  Widget terceraPagina() {
    return PerfilPage();
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
          homePage(),
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
