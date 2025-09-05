import 'package:zoo_connect_app/screens/home/home.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ZooConnect',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
      ),
      home: Home(),
    );
  }
}
