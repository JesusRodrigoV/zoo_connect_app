import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class SurveyResponsesListPage extends ConsumerStatefulWidget {
  const SurveyResponsesListPage({super.key});

  @override
  ConsumerState<SurveyResponsesListPage> createState() =>
      _SurveyResponsesListPageState();
}

class _SurveyResponsesListPageState
    extends ConsumerState<SurveyResponsesListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(surveyProvider.notifier).loadUserParticipations(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surveyState = ref.watch(surveyProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Mis Respuestas'), centerTitle: true),
      body: surveyState.isLoading
          ? const Center(child: CustomLoader())
          : surveyState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${surveyState.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: Colors.red),
                  ),
                  const SizedBox(height: 16),
                  FilledButton.icon(
                    onPressed: () {
                      ref
                          .read(surveyProvider.notifier)
                          .loadUserParticipations();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : surveyState.participations.isEmpty
          ? const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.poll_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No has participado en ninguna encuesta',
                    style: TextStyle(color: Colors.grey),
                  ),
                ],
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: surveyState.participations.length,
              itemBuilder: (context, index) {
                final participation = surveyState.participations[index];
                return _ParticipationCard(
                  participation: participation,
                  onTap: () {
                    Navigator.pushNamed(
                      context,
                      '/surveys/responses/detail',
                      arguments: participation.id,
                    );
                  },
                );
              },
            ),
    );
  }
}

class _ParticipationCard extends StatelessWidget {
  final SurveyParticipation participation;
  final VoidCallback onTap;

  const _ParticipationCard({required this.participation, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(Icons.poll, size: 24),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Encuesta #${participation.encuestaId}',
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Participación #${participation.id}',
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  const Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: Colors.grey,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Respondida el ${dateFormat.format(participation.fechaParticipacion)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
