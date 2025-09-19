import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class ParticipationDetailPage extends ConsumerStatefulWidget {
  final int participationId;

  const ParticipationDetailPage({super.key, required this.participationId});

  @override
  ConsumerState<ParticipationDetailPage> createState() =>
      _ParticipationDetailPageState();
}

class _ParticipationDetailPageState
    extends ConsumerState<ParticipationDetailPage> {
  late Future<SurveyParticipation> _participacionFuture;

  @override
  void initState() {
    super.initState();
    _cargarParticipacion();
  }

  void _cargarParticipacion() {
    final surveyRepository = ref.read(surveyRepositoryProvider);
    _participacionFuture = surveyRepository
        .getParticipationDetails(widget.participationId)
        .then((json) => SurveyParticipation.fromJson(json));
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(title: Text('Detalles de Participación')),
      body: FutureBuilder<SurveyParticipation>(
        future: _participacionFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CustomLoader(size: 60));
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final participacion = snapshot.data!;

          return SingleChildScrollView(
            padding: EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  child: Padding(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Información General',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Divider(),
                        _buildInfoRow(
                          'Estado:',
                          participacion.completada
                              ? 'Completada'
                              : 'En progreso',
                          icon: participacion.completada
                              ? Icons.check_circle
                              : Icons.pending_actions,
                          iconColor: participacion.completada
                              ? colors.primary
                              : colors.error,
                        ),
                        _buildInfoRow(
                          'Fecha:',
                          participacion.fechaParticipacion.toString().split(
                            '.',
                          )[0],
                          icon: Icons.calendar_today,
                        ),
                        _buildInfoRow(
                          'ID Encuesta:',
                          '#${participacion.encuestaId}',
                          icon: Icons.assignment,
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'Respuestas',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                SizedBox(height: 10),
                if (participacion.respuestas.isEmpty)
                  Card(
                    child: Padding(
                      padding: EdgeInsets.all(16),
                      child: Center(
                        child: Text('No hay respuestas registradas'),
                      ),
                    ),
                  )
                else
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: participacion.respuestas.length,
                    itemBuilder: (context, index) {
                      final respuesta = participacion.respuestas[index];
                      return Card(
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundColor: colors.primaryContainer,
                            child: Text('${index + 1}'),
                          ),
                          title: Text('Pregunta #${respuesta.preguntaId}'),
                          subtitle: respuesta.respuestaTexto != null
                              ? Text(respuesta.respuestaTexto!)
                              : Text('Opción: #${respuesta.opcionId}'),
                        ),
                      );
                    },
                  ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildInfoRow(
    String label,
    String value, {
    IconData? icon,
    Color? iconColor,
  }) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          if (icon != null) ...[
            Icon(
              icon,
              color: iconColor ?? Theme.of(context).colorScheme.primary,
            ),
            SizedBox(width: 8),
          ],
          Text(label, style: TextStyle(fontWeight: FontWeight.bold)),
          SizedBox(width: 8),
          Text(value),
        ],
      ),
    );
  }
}
