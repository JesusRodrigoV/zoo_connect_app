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

  Future<void> _loadStats(Survey survey) async {
    try {
      final stats = await ref
          .read(surveyProvider.notifier)
          .loadSurveyStats(survey.id.toString());
      setState(() {
        _selectedStats = stats;
      });
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
                          onTap: () => _loadStats(survey),
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
    if (_selectedStats == null) return const SizedBox.shrink();

    final questionStats =
        _selectedStats!['questionStats'] as Map<String, dynamic>;
    final totalResponses = _selectedStats!['totalResponses'] as int? ?? 0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Total de respuestas: $totalResponses',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        const SizedBox(height: 24),
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
