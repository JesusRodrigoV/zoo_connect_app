import 'package:flutter/material.dart';

class EncuestaPage extends StatefulWidget {
  const EncuestaPage({super.key});

  @override
  State<EncuestaPage> createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<EncuestaPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator,
          icon: Icon(Icons.arrow_back_ios_new),
        ),
        title: Text("Encuesta"),
        centerTitle: true,
      ),
      body: Container(),
    );
  }
}
