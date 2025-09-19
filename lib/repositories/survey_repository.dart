import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';
import 'package:zoo_connect_app/models/survey/survey_question.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';
import 'package:http/http.dart' as http;

class SurveyRepository {
  final String _baseUrl =
      dotenv.env['BASE_URL'] ?? 'http://localhost:8000/api/v1';
  String get _surveysUrl => '$_baseUrl/surveys';
  final Ref ref;

  SurveyRepository(this.ref);

  Future<List<Survey>> getSurveys({String? titulo, DateTime? fecha}) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    var url = Uri.parse(_surveysUrl);

    if (titulo != null || fecha != null) {
      final queryParams = <String, String>{};
      if (titulo != null) queryParams['titulo'] = titulo;
      if (fecha != null) queryParams['fecha'] = fecha.toIso8601String();
      url = url.replace(queryParameters: queryParams);
    }

    final response = await http.get(
      url,
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Survey.fromJson(json)).toList();
    } else {
      throw Exception('Error al obtener encuestas');
    }
  }

  Future<Survey> getSurveyById(int id) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final response = await http.get(
      Uri.parse('$_surveysUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Survey.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al obtener la encuesta');
    }
  }

  Future<Survey> createSurvey(Survey survey) async {
    try {
      final token = ref.read(getTokenAccesoProvider);
      if (token == null) throw Exception('No autorizado');

      print('URL: $_surveysUrl'); // Debug
      print('Token: $token'); // Debug
      print('Survey data: ${json.encode(survey.toJson())}'); // Debug

      final response = await http.post(
        Uri.parse(_surveysUrl),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
        body: json.encode(survey.toJson()),
      );

      print('Response status: ${response.statusCode}'); // Debug
      print('Response body: ${response.body}'); // Debug

      if (response.statusCode == 201) {
        return Survey.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Error al crear la encuesta: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      print('Error detallado: $e'); // Debug
      throw Exception('Error al crear la encuesta: $e');
    }
  }

  Future<Survey> updateSurvey(int id, Map<String, dynamic> data) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final response = await http.put(
      Uri.parse('$_surveysUrl/$id'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(data),
    );

    if (response.statusCode == 200) {
      return Survey.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al actualizar la encuesta');
    }
  }

  Future<void> deleteSurvey(int id) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final response = await http.delete(
      Uri.parse('$_surveysUrl/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode != 204) {
      throw Exception('Error al eliminar la encuesta');
    }
  }

  Future<SurveyParticipation> participateInSurvey(
    int surveyId,
    List<SurveyAnswer> answers,
  ) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final response = await http.post(
      Uri.parse('$_surveysUrl/participar'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({
        'encuesta_id': surveyId,
        'respuestas': answers.map((a) => a.toJson()).toList(),
      }),
    );

    if (response.statusCode == 201) {
      return SurveyParticipation.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al participar en la encuesta');
    }
  }

  Future<SurveyQuestion> addQuestionToSurvey(
    int surveyId,
    SurveyQuestion question,
  ) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final response = await http.post(
      Uri.parse('$_surveysUrl/$surveyId/preguntas'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode(question.toJson()),
    );

    if (response.statusCode == 201) {
      return SurveyQuestion.fromJson(json.decode(response.body));
    } else {
      throw Exception('Error al agregar la pregunta');
    }
  }
}
