import 'package:flutter/material.dart';
import 'package:zoo_connect_app/screens/quiz/quiz_bienvenida.dart';
import 'package:zoo_connect_app/screens/settings/settings.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int currentPageIndex = 0;

  Widget homePage() {
    return Center(child: Text("Primera Pagina"));
  }

  Widget quizPage() {
    return QuizBienvenida();
  }

  Widget settingsPage() {
    return SettingsPage();
  }

  NavigationBar navigationBar() {
    return NavigationBar(
      onDestinationSelected: (int index) {
        setState(() {
          currentPageIndex = index;
        });
      },
      labelBehavior: NavigationDestinationLabelBehavior.onlyShowSelected,
      indicatorColor: Colors.teal,
      selectedIndex: currentPageIndex,
      destinations: [
        NavigationDestination(
          selectedIcon: Icon(Icons.home_filled),
          icon: Icon(Icons.home_outlined),
          label: 'Inicio',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.quiz_outlined),
          icon: Icon(Icons.quiz),
          label: 'Quiz',
        ),
        NavigationDestination(
          selectedIcon: Icon(Icons.person_2), 
          icon: Icon(Icons.person_2_outlined), 
          label: 'Perfil'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[homePage(), quizPage(), settingsPage()][currentPageIndex],
      bottomNavigationBar: navigationBar(),
    );
  }
}
