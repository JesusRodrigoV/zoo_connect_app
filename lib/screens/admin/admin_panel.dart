import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/widgets/survey/admin_survey_card.dart';

class AdminPanelPage extends ConsumerWidget {
  const AdminPanelPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Panel de Administración'),
        centerTitle: true,
      ),
      body: GridView.count(
        padding: const EdgeInsets.all(16),
        crossAxisCount: 2,
        mainAxisSpacing: 16,
        crossAxisSpacing: 16,
        children: [
          AdminSurveyCard(
            title: 'Gestionar Encuestas',
            description: 'Crear, editar y eliminar encuestas',
            icon: Icons.quiz,
            onTap: () => Navigator.pushNamed(context, '/surveys'),
          ),
          AdminSurveyCard(
            title: 'Nueva Encuesta',
            description: 'Crear una nueva encuesta',
            icon: Icons.add_circle_outline,
            onTap: () => Navigator.pushNamed(context, '/surveys/create'),
          ),
          AdminSurveyCard(
            title: 'Ver Respuestas',
            description: 'Analizar resultados de encuestas',
            icon: Icons.analytics_outlined,
            onTap: () {},
          ),
          AdminSurveyCard(
            title: 'Usuarios',
            description: 'Gestionar usuarios y permisos',
            icon: Icons.people_outline,
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
