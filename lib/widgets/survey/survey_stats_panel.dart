import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class SurveyStatsPanel extends StatelessWidget {
  final Map<String, dynamic> stats;

  const SurveyStatsPanel({super.key, required this.stats});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final questionStats =
        stats['estadisticas_preguntas'] as Map<String, dynamic>? ?? {};

    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Estadísticas',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: colors.primary,
                ),
              ),
              const Spacer(),
              Card(
                color: colors.primaryContainer,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 8,
                  ),
                  child: Text(
                    'Total: ${stats['total_participaciones'] ?? 0} respuestas',
                    style: TextStyle(
                      color: colors.onPrimaryContainer,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          ...questionStats.entries.map((entry) {
            final questionId = entry.key;
            final questionData = entry.value as Map<String, dynamic>;
            final questionText =
                questionData['question_text'] as String? ??
                'Pregunta $questionId';
            final optionStats =
                questionData['option_stats'] as Map<String, dynamic>? ?? {};

            return Card(
              margin: const EdgeInsets.symmetric(vertical: 8),
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
                      height: 300, // Increased height for better visualization
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 100,
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
                                    color: colors.primary,
                                    width: 25,
                                    borderRadius: const BorderRadius.vertical(
                                      top: Radius.circular(4),
                                    ),
                                  ),
                                ],
                              );
                            }).toList(),
                          ],
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  final options = optionStats.keys.toList();
                                  if (value >= 0 && value < options.length) {
                                    return Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        'Opción ${value + 1}',
                                        textAlign: TextAlign.center,
                                        style: const TextStyle(fontSize: 12),
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
                                  return Padding(
                                    padding: const EdgeInsets.only(right: 8),
                                    child: Text(
                                      '${value.toInt()}%',
                                      style: const TextStyle(fontSize: 12),
                                    ),
                                  );
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
                          gridData: const FlGridData(show: true),
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
                      final percentage = optionData['percentage'] as num? ?? 0;

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
  }
}
