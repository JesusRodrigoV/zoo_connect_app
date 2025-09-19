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
  Survey? _selectedSurvey;
  bool _isLoadingStats = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(surveyProvider.notifier).loadSurveys());
  }

  Future<void> _loadStats(Survey survey) async {
    if (survey.id == null) {
      _showError('ID de encuesta no válido');
      return;
    }

    setState(() => _isLoadingStats = true);

    try {
      final stats = await ref
          .read(surveyProvider.notifier)
          .loadSurveyStats(survey.id!);

      if (mounted) {
        setState(() {
          _selectedStats = stats;
          _selectedSurvey = survey;
          _isLoadingStats = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() => _isLoadingStats = false);
        _showError('Error al cargar estadísticas: $e');
      }
    }
  }

  void _showError(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.error,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final surveyState = ref.watch(surveyProvider);
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Estadísticas de Encuestas'),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            constraints: const BoxConstraints(minHeight: 120, maxHeight: 200),
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: _buildSurveySelector(surveyState, colors),
          ),
          const Divider(height: 1),
          Expanded(child: _buildStatsArea(colors)),
        ],
      ),
    );
  }

  Widget _buildSurveySelector(dynamic surveyState, ColorScheme colors) {
    if (surveyState.isLoading) {
      return const Center(child: CustomLoader());
    }

    if (surveyState.error != null) {
      return _buildError(surveyState.error!, colors);
    }

    if (surveyState.surveys.isEmpty) {
      return const Center(
        child: Text(
          'No hay encuestas disponibles',
          style: TextStyle(color: Colors.grey),
        ),
      );
    }

    return ListView.builder(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: surveyState.surveys.length,
      itemBuilder: (context, index) {
        final survey = surveyState.surveys[index];
        final isSelected = survey == _selectedSurvey;

        return Container(
          width: 300,
          margin: const EdgeInsets.only(right: 12),
          child: Card(
            elevation: isSelected ? 4 : 1,
            color: isSelected ? colors.primaryContainer : null,
            child: InkWell(
              onTap: () => _loadStats(survey),
              borderRadius: BorderRadius.circular(12),
              child: Container(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      survey.titulo,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: isSelected ? colors.onPrimaryContainer : null,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      survey.descripcion,
                      style: TextStyle(
                        fontSize: 13,
                        color: isSelected
                            ? colors.onPrimaryContainer
                            : colors.onSurfaceVariant,
                      ),
                      maxLines: 3,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (isSelected) ...[
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: colors.primary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          'Seleccionada',
                          style: TextStyle(
                            color: colors.onPrimary,
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget _buildStatsArea(ColorScheme colors) {
    if (_isLoadingStats) {
      return const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomLoader(),
            SizedBox(height: 16),
            Text('Cargando estadísticas...'),
          ],
        ),
      );
    }

    if (_selectedStats == null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.analytics_outlined,
              size: 64,
              color: colors.primary.withAlpha(155),
            ),
            const SizedBox(height: 16),
            Text(
              'Selecciona una encuesta',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                color: colors.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'para ver sus estadísticas',
              style: TextStyle(fontSize: 14, color: colors.onSurfaceVariant),
            ),
          ],
        ),
      );
    }

    return _buildStatistics(colors);
  }

  Widget _buildStatistics(ColorScheme colors) {
    try {
      final stats = _selectedStats!;
      final totalResponses = _getTotalResponses(stats);
      final questionStats = _getQuestionStats(stats);

      if (questionStats.isEmpty) {
        return const Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.insert_chart_outlined, size: 64, color: Colors.grey),
              SizedBox(height: 16),
              Text(
                'No hay datos de respuestas disponibles',
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ],
          ),
        );
      }

      return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Theme.of(context).colorScheme.primaryContainer,
                    Theme.of(
                      context,
                    ).colorScheme.primaryContainer.withAlpha(155),
                  ],
                ),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    _selectedSurvey?.titulo ?? 'Encuesta',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(
                        Icons.people_outline,
                        size: 20,
                        color: Theme.of(context).colorScheme.onPrimaryContainer,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Total de participaciones: $totalResponses',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // Gráficos por pregunta
            ...questionStats.entries.map((entry) {
              return _buildQuestionChart(entry.key, entry.value, colors);
            }),

            const SizedBox(height: 32),
          ],
        ),
      );
    } catch (e) {
      debugPrint('Error mostrando estadísticas: $e');
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, size: 64, color: Colors.red),
            const SizedBox(height: 16),
            Text(
              'Error al procesar estadísticas',
              style: TextStyle(
                color: Theme.of(context).colorScheme.error,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              e.toString(),
              style: const TextStyle(color: Colors.grey),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
    }
  }

  Widget _buildQuestionChart(
    String questionId,
    Map<String, dynamic> questionData,
    ColorScheme colors,
  ) {
    final questionText = _getQuestionText(questionData);
    final options = _getQuestionOptions(questionData);

    if (options.isEmpty) {
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
              const Center(
                child: Column(
                  children: [
                    Icon(Icons.info_outline, size: 48, color: Colors.grey),
                    SizedBox(height: 8),
                    Text(
                      'No hay respuestas para esta pregunta',
                      style: TextStyle(color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }

    final validOptions = <String, Map<String, dynamic>>{};
    int totalValidResponses = 0;

    for (final entry in options.entries) {
      final optionData = entry.value as Map<String, dynamic>? ?? {};
      final count = _getResponseCount(optionData);
      if (count > 0 || entry.key != 'None') {
        validOptions[entry.key] = optionData;
        totalValidResponses += count;
      }
    }

    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              questionText,
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              'Total de respuestas: $totalValidResponses',
              style: TextStyle(color: colors.onPrimary, fontSize: 14),
            ),
            const SizedBox(height: 24),

            if (validOptions.isNotEmpty) ...[
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: totalValidResponses > 0 ? 100 : 10,
                    titlesData: _buildChartTitles(
                      validOptions,
                      totalValidResponses,
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border(
                        bottom: BorderSide(color: Colors.grey[300]!),
                        left: BorderSide(color: Colors.grey[300]!),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: 20,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(color: Colors.grey[200]!, strokeWidth: 1);
                      },
                    ),
                    barGroups: _buildBarGroups(
                      validOptions,
                      totalValidResponses,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),

              ...validOptions.entries.map((entry) {
                final optionText = _getOptionText(entry.value);
                final count = _getResponseCount(entry.value);
                final percentage = totalValidResponses > 0
                    ? (count / totalValidResponses * 100)
                    : 0.0;

                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: colors.primaryContainer,
                    borderRadius: BorderRadius.circular(8),
                    border: Border.all(
                      color: colors.primaryContainer.withAlpha(55),
                    ),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 4,
                        height: 40,
                        decoration: BoxDecoration(
                          color: _getBarColor(
                            validOptions.keys.toList().indexOf(entry.key),
                          ),
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              optionText,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '$count respuestas (${percentage.toStringAsFixed(1)}%)',
                              style: TextStyle(
                                fontSize: 12,
                                color: colors.onPrimaryContainer,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ] else
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(32.0),
                  child: Text(
                    'No hay respuestas válidas',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  int _getTotalResponses(Map<String, dynamic> stats) {
    return (stats['total_participaciones'] as int? ??
            stats['totalResponses'] as int? ??
            stats['total_responses'] as int?) ??
        0;
  }

  Map<String, dynamic> _getQuestionStats(Map<String, dynamic> stats) {
    return (stats['estadisticas_preguntas'] as Map<String, dynamic>? ??
            stats['questionStats'] as Map<String, dynamic>? ??
            stats['question_stats'] as Map<String, dynamic>?) ??
        {};
  }

  String _getQuestionText(Map<String, dynamic> questionData) {
    return (questionData['texto_pregunta'] as String? ??
            questionData['question_text'] as String? ??
            questionData['pregunta_texto'] as String?) ??
        'Pregunta sin texto';
  }

  Map<String, dynamic> _getQuestionOptions(Map<String, dynamic> questionData) {
    return (questionData['opciones'] as Map<String, dynamic>? ??
            questionData['options'] as Map<String, dynamic>? ??
            questionData['answers'] as Map<String, dynamic>?) ??
        {};
  }

  String _getOptionText(Map<String, dynamic> optionData) {
    return (optionData['texto_opcion'] as String? ??
            optionData['option_text'] as String? ??
            optionData['text'] as String?) ??
        'Respuesta de texto';
  }

  int _getResponseCount(Map<String, dynamic> optionData) {
    return (optionData['conteo_respuestas'] as int? ??
            optionData['count'] as int? ??
            optionData['response_count'] as int?) ??
        0;
  }

  FlTitlesData _buildChartTitles(Map<String, dynamic> options, int total) {
    return FlTitlesData(
      show: true,
      bottomTitles: AxisTitles(
        sideTitles: SideTitles(
          showTitles: true,
          reservedSize: 40,
          getTitlesWidget: (value, meta) {
            final optionKeys = options.keys.toList();
            final index = value.toInt();

            if (index >= 0 && index < optionKeys.length) {
              return Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Op. ${index + 1}',
                  style: const TextStyle(
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
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
          reservedSize: 40,
          interval: 20,
          getTitlesWidget: (value, meta) {
            return Text(
              '${value.toInt()}%',
              style: const TextStyle(fontSize: 10),
            );
          },
        ),
      ),
      rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
      topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
    );
  }

  List<BarChartGroupData> _buildBarGroups(
    Map<String, dynamic> options,
    int total,
  ) {
    final optionEntries = options.entries.toList();

    return optionEntries.asMap().entries.map((entry) {
      final index = entry.key;
      final optionData = entry.value.value as Map<String, dynamic>;
      final count = _getResponseCount(optionData);
      final percentage = total > 0 ? (count / total * 100) : 0.0;

      return BarChartGroupData(
        x: index,
        barRods: [
          BarChartRodData(
            toY: percentage,
            color: _getBarColor(index),
            width: 24,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(4)),
          ),
        ],
      );
    }).toList();
  }

  Color _getBarColor(int index) {
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.purple,
      Colors.red,
      Colors.teal,
      Colors.pink,
      Colors.indigo,
    ];
    return colors[index % colors.length];
  }

  Widget _buildError(String error, ColorScheme colors) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.error_outline, size: 48, color: colors.error),
            const SizedBox(height: 16),
            Text(
              'Error al cargar encuestas',
              style: TextStyle(
                color: colors.error,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              error,
              style: TextStyle(color: colors.onSurfaceVariant),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            FilledButton.icon(
              onPressed: () => ref.read(surveyProvider.notifier).loadSurveys(),
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
