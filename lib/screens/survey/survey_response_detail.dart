import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class SurveyResponseDetailPage extends ConsumerStatefulWidget {
  final String participationId;

  const SurveyResponseDetailPage({super.key, required this.participationId});

  @override
  ConsumerState<SurveyResponseDetailPage> createState() =>
      _SurveyResponseDetailPageState();
}

class _SurveyResponseDetailPageState
    extends ConsumerState<SurveyResponseDetailPage> {
  Map<String, dynamic>? _stats;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref
          .read(surveyProvider.notifier)
          .loadParticipationDetails(widget.participationId);
    });
  }

  Future<void> _loadStats() async {
    try {
      final participation = ref.read(surveyProvider).selectedParticipation;
      if (participation != null) {
        final stats = await ref
            .read(surveyProvider.notifier)
            .loadSurveyStats(participation.encuestaId.toString());
        setState(() {
          _stats = stats;
        });
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar estadísticas: $e'),
            backgroundColor: Colors.red,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyState = ref.watch(surveyProvider);
    final participation = surveyState.selectedParticipation;

    return Scaffold(
      appBar: AppBar(
        title: Text('Encuesta #${participation?.encuestaId ?? ""}'),
        centerTitle: true,
      ),
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
                          .loadParticipationDetails(widget.participationId);
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : participation == null
          ? const Center(child: Text('No se encontró la participación'))
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSurveyInfo(participation),
                  const SizedBox(height: 24),
                  _buildAnswersList(participation),
                  if (_stats != null) ...[
                    const SizedBox(height: 24),
                    _buildStatistics(),
                  ] else
                    Center(
                      child: FilledButton.icon(
                        onPressed: _loadStats,
                        icon: const Icon(Icons.analytics),
                        label: const Text('Cargar Estadísticas'),
                      ),
                    ),
                ],
              ),
            ),
    );
  }

  Widget _buildSurveyInfo(SurveyParticipation participation) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy HH:mm');

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Encuesta #${participation.encuestaId}',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Participación #${participation.id}',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
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
    );
  }

  Widget _buildAnswersList(SurveyParticipation participation) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tus Respuestas',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: participation.respuestas.length,
          itemBuilder: (context, index) {
            final answer = participation.respuestas[index];
            return Card(
              margin: const EdgeInsets.only(bottom: 12),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Pregunta ${index + 1}',
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: Colors.grey[600],
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      answer.respuestaTexto ??
                          answer.opcionId?.toString() ??
                          'Sin respuesta',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  Widget _buildStatistics() {
    if (_stats == null) return const SizedBox.shrink();

    final theme = Theme.of(context);
    final questionStats = _stats!['questionStats'] as Map<String, dynamic>;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Estadísticas de la Encuesta',
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 300,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: 100,
              barGroups: questionStats.entries.map((entry) {
                final answers = entry.value as Map<String, dynamic>;
                final total = answers['total'] as int;
                final counts = answers['answers'] as Map<String, dynamic>;

                return BarChartGroupData(
                  x: int.parse(entry.key),
                  barRods: counts.entries.map((answer) {
                    final count = answer.value as int;
                    final percentage = (count / total) * 100;

                    return BarChartRodData(
                      toY: percentage,
                      color: Colors.blue,
                      width: 16,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(4),
                      ),
                    );
                  }).toList(),
                );
              }).toList(),
              titlesData: FlTitlesData(
                show: true,
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text('P${value.toInt() + 1}');
                    },
                  ),
                ),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (value, meta) {
                      return Text('${value.toInt()}%');
                    },
                    reservedSize: 40,
                  ),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              gridData: const FlGridData(show: true, drawVerticalLine: false),
              borderData: FlBorderData(
                show: true,
                border: Border.all(color: Colors.grey.shade300),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
