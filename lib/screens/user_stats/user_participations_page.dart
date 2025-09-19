import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/auth/usuario.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/screens/user_stats/participation_detail_page.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class UserParticipationsPage extends ConsumerStatefulWidget {
  final Usuario usuario;

  const UserParticipationsPage({super.key, required this.usuario});

  @override
  ConsumerState<UserParticipationsPage> createState() =>
      _UserParticipationsPageState();
}

class _UserParticipationsPageState
    extends ConsumerState<UserParticipationsPage> {
  late Future<List<SurveyParticipation>> _participacionesFuture;

  @override
  void initState() {
    super.initState();
    _cargarParticipaciones();
  }

  void _cargarParticipaciones() {
    final surveyRepository = ref.read(surveyRepositoryProvider);
    _participacionesFuture = surveyRepository.getUserParticipations();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Mis Participaciones')),
      body: RefreshIndicator(
        onRefresh: () async {
          setState(() {
            _cargarParticipaciones();
          });
        },
        child: FutureBuilder<List<SurveyParticipation>>(
          future: _participacionesFuture,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CustomLoader(size: 60));
            }

            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final participaciones = snapshot.data ?? [];

            if (participaciones.isEmpty) {
              return Center(
                child: Text('No has participado en ninguna encuesta aún.'),
              );
            }

            return ListView.builder(
              itemCount: participaciones.length,
              itemBuilder: (context, index) {
                final participacion = participaciones[index];
                return Card(
                  margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: ListTile(
                    leading: Icon(
                      participacion.completada
                          ? Icons.check_circle
                          : Icons.pending_actions,
                      color: participacion.completada
                          ? colors.primary
                          : colors.error,
                    ),
                    title: Text(
                      'Encuesta #${participacion.encuestaId}',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Fecha: ${participacion.fechaParticipacion.toString().split('.')[0]}',
                        ),
                        Text(
                          participacion.completada
                              ? 'Completada'
                              : 'En progreso',
                          style: TextStyle(
                            color: participacion.completada
                                ? colors.primary
                                : colors.error,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(Icons.chevron_right),
                    onTap: () {
                      // Navegar al detalle de la participación
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ParticipationDetailPage(
                            participationId: participacion.id,
                          ),
                        ),
                      );
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
