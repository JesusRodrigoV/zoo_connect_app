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

  Future<void> createSurvey(Survey survey) async {
    try {
      print('Iniciando creación de encuesta...'); // Debug
      state = state.copyWith(isLoading: true, error: null);

      print('Datos de la encuesta:'); // Debug
      print('Título: ${survey.titulo}'); // Debug
      print('Descripción: ${survey.descripcion}'); // Debug
      print('Fecha inicio: ${survey.fechaInicio}'); // Debug
      print('Fecha fin: ${survey.fechaFin}'); // Debug
      print('Preguntas: ${survey.preguntas.length}'); // Debug

      final newSurvey = await _repository.createSurvey(survey);
      print('Encuesta creada exitosamente: ${newSurvey.id}'); // Debug

      state = state.copyWith(
        surveys: [...state.surveys, newSurvey],
        isLoading: false,
      );
    } catch (e, stackTrace) {
      print('Error al crear encuesta: $e'); // Debug
      print('Stack trace: $stackTrace'); // Debug
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

  // Cargar todas las participaciones del usuario
  Future<void> loadUserParticipations() async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final participations = await _repository.getUserParticipations();
      state = state.copyWith(participations: participations, isLoading: false);
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Cargar los detalles de una participación específica
  Future<void> loadParticipationDetails(String participationId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final participation = await _repository.getParticipationDetails(
        int.parse(participationId),
      );
      state = state.copyWith(
        selectedParticipation: participation,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
    }
  }

  // Cargar estadísticas de una encuesta
  Future<Map<String, dynamic>> loadSurveyStats(String surveyId) async {
    try {
      state = state.copyWith(isLoading: true, error: null);
      final stats = await _repository.getSurveyStats(int.parse(surveyId));
      state = state.copyWith(isLoading: false);
      return stats;
    } catch (e) {
      state = state.copyWith(error: e.toString(), isLoading: false);
      rethrow;
    }
  }
}
