import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/widgets/home/animal_dia.dart';
import 'package:zoo_connect_app/widgets/home/encuesta_card.dart';
import 'package:zoo_connect_app/widgets/home/quiz_card.dart';
import 'package:zoo_connect_app/widgets/profile/profile_icon_button.dart';
import 'package:zoo_connect_app/widgets/shared/user_widgets.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(surveyProvider.notifier).loadSurveys());
  }

  @override
  Widget build(BuildContext context) {
    final surveyState = ref.watch(surveyProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text("ZooConnet"),
        centerTitle: true,
        actions: [
          AdminOnly(
            child: IconButton(
              onPressed: () => Navigator.pushNamed(context, '/admin'),
              icon: Icon(Icons.admin_panel_settings),
              tooltip: 'Panel de Administración',
            ),
          ),
          ProfileIconButton(),
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              AnimalDia(),
              const SizedBox(height: 10),
              Text(
                'Encuestas Disponibles',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 0.1,
                ),
              ),
              SizedBox(height: 10),
              if (surveyState.isLoading)
                const SizedBox(
                  height: 250,
                  child: Center(child: CircularProgressIndicator()),
                )
              else if (surveyState.error != null)
                SizedBox(
                  height: 250,
                  child: Center(
                    child: Text(
                      'Error al cargar encuestas: ${surveyState.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ),
                )
              else if (surveyState.surveys.isEmpty)
                const SizedBox(
                  height: 250,
                  child: Center(
                    child: Text(
                      'No hay encuestas disponibles',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                )
              else
                SizedBox(
                  height: 250,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: surveyState.surveys.length,
                    itemBuilder: (context, index) {
                      final survey = surveyState.surveys[index];
                      final now = DateTime.now();
                      if (!survey.isActive ||
                          now.isBefore(survey.fechaInicio) ||
                          now.isAfter(survey.fechaFin)) {
                        return const SizedBox.shrink();
                      }
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: EncuestaCard(encuesta: survey),
                      );
                    },
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
