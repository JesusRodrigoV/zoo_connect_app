import 'package:flutter/material.dart';
import 'package:zoo_connect_app/screens/home/home_page.dart';
import 'package:zoo_connect_app/screens/quiz/quiz_bienvenida.dart';

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

  Widget quizPage() {
    return QuizBienvenida();
  }

  Widget algoMasPage() {
    return Center(child: Text("Tercera Pagina"));
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
        NavigationDestination(icon: Icon(Icons.person), label: 'Algo Mas'),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: <Widget>[homePage(), quizPage(), algoMasPage()][currentPageIndex],
      bottomNavigationBar: navigationBar(),
    );
  }
}
