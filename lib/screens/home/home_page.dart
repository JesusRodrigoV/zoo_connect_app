import 'package:flutter/material.dart';
import 'package:zoo_connect_app/widgets/home/animal_dia.dart';
import 'package:zoo_connect_app/widgets/home/encuesta_card.dart';
import 'package:zoo_connect_app/widgets/home/quiz_card.dart';
import 'package:zoo_connect_app/widgets/profile/profile_icon_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("ZooConnet"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () => Navigator.pushNamed(context, '/bienvenida'),
            icon: Icon(Icons.abc),
          ),
          IconButton.filledTonal(onPressed: () {}, icon: Icon(Icons.person)),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            children: [
              AnimalDia(),
              const SizedBox(height: 10),
              SizedBox(
                height: 250,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: [
                    EncuestaCard(
                      titulo: "Nuevo habitat",
                      contenido:
                          "Ayudanos a hacer esto no se que no se aqui no se alla, mas pruebas mas texto largo para ver si soporta",
                    ),
                    EncuestaCard(
                      titulo: "Nombre para algo",
                      contenido: "Elige nombre para el nuevo lion ",
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              QuizCard(),
            ],
          ),
        ),
      ),
    );
  }
}
