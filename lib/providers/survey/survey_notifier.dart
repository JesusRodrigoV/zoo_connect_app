import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';
import 'package:zoo_connect_app/providers/survey/survey_state.dart';
import 'package:zoo_connect_app/repositories/survey_repository.dart';

class SurveyNotifier extends StateNotifier<SurveyState> {
  final SurveyRepository _repository;

  SurveyNotifier({required SurveyRepository repository})
    : _repository = repository,
      super(const SurveyState());

  Future<void> loadSurveys({String? titulo, DateTime? fecha}) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final surveys = await _repository.getSurveys(
        titulo: titulo,
        fecha: fecha,
      );
      state = state.copyWith(surveys: surveys, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadSurveyById(int id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final survey = await _repository.getSurveyById(id);
      final stats = await _repository.getSurveyStats(id);

      state = state.copyWith(
        selectedSurvey: survey,
        selectedSurveyStats: stats,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> createSurvey(Survey survey) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final newSurvey = await _repository.createSurvey(survey);
      state = state.copyWith(
        surveys: [...state.surveys, newSurvey],
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> updateSurvey(int id, Map<String, dynamic> data) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final updatedSurvey = await _repository.updateSurvey(id, data);
      final updatedSurveys = state.surveys.map((survey) {
        return survey.id == id ? updatedSurvey : survey;
      }).toList();
      state = state.copyWith(surveys: updatedSurveys, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> deleteSurvey(int id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _repository.deleteSurvey(id);
      final updatedSurveys = state.surveys
          .where((survey) => survey.id != id)
          .toList();
      state = state.copyWith(surveys: updatedSurveys, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> selectSurvey(int id) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final survey = await _repository.getSurveyById(id);
      state = state.copyWith(selectedSurvey: survey, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> participateInSurvey(
    int surveyId,
    List<SurveyAnswer> answers,
  ) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      await _repository.participateInSurvey(surveyId, answers);
      state = state.copyWith(isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadUserParticipations() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final participations = await _repository.getUserParticipations();
      state = state.copyWith(participations: participations, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<void> loadParticipationDetails(String participationId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final participationData = await _repository.getParticipationDetails(
        int.parse(participationId),
      );
      state = state.copyWith(
        selectedParticipation: SurveyParticipation.fromJson(participationData),
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  Future<Map<String, dynamic>> loadSurveyStats(String surveyId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final stats = await _repository.getSurveyStats(int.parse(surveyId));
      state = state.copyWith(selectedSurveyStats: stats, isLoading: false);
      return stats;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      rethrow;
    }
  }

  Future<void> loadAllStats() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final stats = await _repository.getAllStats();
      state = state.copyWith(surveyStats: stats, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }
}
