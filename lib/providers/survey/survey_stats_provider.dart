import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/repositories/survey_repository.dart';
import 'package:zoo_connect_app/providers/survey/survey_repository_provider.dart';

final surveyStatsProvider =
    StateNotifierProvider<SurveyStatsNotifier, Map<String, dynamic>?>((ref) {
      final repository = ref.watch(surveyRepositoryProvider);
      return SurveyStatsNotifier(repository);
    });

class SurveyStatsNotifier extends StateNotifier<Map<String, dynamic>?> {
  final SurveyRepository _repository;

  SurveyStatsNotifier(this._repository) : super(null);

  Future<void> loadStats(int surveyId) async {
    try {
      state = null; // Limpiar estado anterior
      final stats = await _repository.getSurveyStats(surveyId);
      state = stats;
    } catch (e) {
      throw Exception('Error al cargar estadísticas: $e');
    }
  }

  void clear() {
    state = null;
  }
}
