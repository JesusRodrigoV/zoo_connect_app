import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class SurveyStatsPage extends ConsumerStatefulWidget {
  const SurveyStatsPage({super.key});

  @override
  ConsumerState<SurveyStatsPage> createState() => _SurveyStatsPageState();
}

class _SurveyStatsPageState extends ConsumerState<SurveyStatsPage> {
  Map<String, dynamic>? _selectedStats;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(surveyProvider.notifier).loadSurveys());
  }

  Future<void> _loadStats(Survey survey, ColorScheme colors) async {
    if (survey.id == null) return;

    try {
      final stats = await ref
          .read(surveyProvider.notifier)
          .loadSurveyStats(survey.id!);
      setState(() {
        _selectedStats = stats;
      });
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error al cargar estadísticas: $e'),
            backgroundColor: colors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final surveyState = ref.watch(surveyProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Resultados de Encuestas'),
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
                      ref.read(surveyProvider.notifier).loadSurveys();
                    },
                    icon: const Icon(Icons.refresh),
                    label: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : surveyState.surveys.isEmpty
          ? const Center(child: Text('No hay encuestas disponibles'))
          : Row(
              children: [
                SizedBox(
                  width: 300,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: surveyState.surveys.length,
                    itemBuilder: (context, index) {
                      final survey = surveyState.surveys[index];
                      return Card(
                        child: ListTile(
                          title: Text(survey.titulo),
                          subtitle: Text(survey.descripcion),
                          trailing: const Icon(Icons.chevron_right),
                          onTap: () => _loadStats(survey, colors),
                        ),
                      );
                    },
                  ),
                ),
                const VerticalDivider(width: 1),
                if (_selectedStats != null)
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Estadísticas',
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _buildStatistics(),
                        ],
                      ),
                    ),
                  )
                else
                  const Expanded(
                    child: Center(
                      child: Text(
                        'Selecciona una encuesta para ver sus estadísticas',
                        style: TextStyle(color: Colors.grey),
                      ),
                    ),
                  ),
              ],
            ),
    );
  }

  Widget _buildStatistics() {
    if (_selectedStats == null) {
      return const Center(
        child: Text(
          'No hay datos disponibles',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    try {
      final stats = _selectedStats!;
      if (stats.isEmpty) {
        return const Center(
          child: Text(
            'No hay estadísticas disponibles',
            style: TextStyle(color: Colors.grey),
          ),
        );
      }

      final totalResponses = stats['total_participaciones'] ?? 0;
      final questionStats =
          stats['estadisticas_preguntas'] as Map<String, dynamic>? ?? {};

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Total de respuestas: $totalResponses',
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            const SizedBox(height: 16),
            ...questionStats.entries.map((entry) {
              final questionId = entry.key;
              final questionData = entry.value as Map<String, dynamic>;
              final questionText =
                  questionData['question_text'] as String? ??
                  'Pregunta $questionId';
              final optionStats =
                  questionData['option_stats'] as Map<String, dynamic>? ?? {};

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        questionText,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 200,
                        child: BarChart(
                          BarChartData(
                            alignment: BarChartAlignment.spaceAround,
                            maxY: 100,
                            titlesData: FlTitlesData(
                              show: true,
                              bottomTitles: AxisTitles(
                                sideTitles: SideTitles(
                                  showTitles: true,
                                  getTitlesWidget: (value, meta) {
                                    final options = optionStats.keys.toList();
                                    if (value >= 0 && value < options.length) {
                                      return Padding(
                                        padding: const EdgeInsets.only(
                                          top: 8.0,
                                        ),
                                        child: Text(
                                          'Opción ${value + 1}',
                                          textAlign: TextAlign.center,
                                          style: const TextStyle(fontSize: 10),
                                        ),
                                      );
                                    }
                                    return const Text('');
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
                            borderData: FlBorderData(show: false),
                            gridData: const FlGridData(show: false),
                            barGroups: [
                              ...optionStats.entries.map((optionEntry) {
                                final optionId = optionEntry.key;
                                final optionData =
                                    optionEntry.value as Map<String, dynamic>;
                                final percentage =
                                    optionData['percentage'] as num? ?? 0;

                                return BarChartGroupData(
                                  x: int.tryParse(optionId) ?? 0,
                                  barRods: [
                                    BarChartRodData(
                                      toY: percentage.toDouble(),
                                      color: Colors.blue,
                                      width: 20,
                                      borderRadius: const BorderRadius.vertical(
                                        top: Radius.circular(4),
                                      ),
                                    ),
                                  ],
                                );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 16),
                      ...optionStats.entries.map((optionEntry) {
                        final optionId = optionEntry.key;
                        final optionData =
                            optionEntry.value as Map<String, dynamic>;
                        final optionText =
                            optionData['option_text'] as String? ??
                            'Opción $optionId';
                        final count = optionData['count'] as int? ?? 0;
                        final percentage =
                            optionData['percentage'] as num? ?? 0;

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  optionText,
                                  style: const TextStyle(fontSize: 14),
                                ),
                              ),
                              Text(
                                '$count respuestas (${percentage.toStringAsFixed(1)}%)',
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
              );
            }).toList(),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error mostrando estadísticas: $e');
      return Center(child: Text('Error al procesar las estadísticas: $e'));
    }
  }
}
