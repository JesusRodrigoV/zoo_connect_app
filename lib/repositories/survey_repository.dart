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
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final client = http.Client();
    try {
      var request = http.Request('POST', Uri.parse(_surveysUrl));
      request.headers.addAll({
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });
      request.body = json.encode(survey.toJson());

      final streamedResponse = await client.send(request);
      var response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 307 || response.statusCode == 308) {
        final redirectUrl = response.headers['location'];
        if (redirectUrl != null) {
          request = http.Request('POST', Uri.parse(redirectUrl));
          request.headers.addAll({
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
            'Accept': 'application/json',
          });
          request.body = json.encode(survey.toJson());

          final redirectedResponse = await client.send(request);
          response = await http.Response.fromStream(redirectedResponse);
        }
      } else if (response.statusCode == 401) {
        // Intentar obtener un nuevo token
        final authNotifier = ref.read(authProvider.notifier);
        final tokenRefreshed = await authNotifier.refreshToken();

        if (tokenRefreshed) {
          // Obtener el nuevo token
          final newToken = ref.read(getTokenAccesoProvider);
          if (newToken != null && newToken != token) {
            // Reintentar la petición con el nuevo token
            request = http.Request('POST', Uri.parse(_surveysUrl));
            request.headers.addAll({
              'Authorization': 'Bearer $newToken',
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            });
            request.body = json.encode(survey.toJson());

            final newResponse = await client.send(request);
            response = await http.Response.fromStream(newResponse);
          }
        }
      }

      if (response.statusCode == 201) {
        return Survey.fromJson(json.decode(response.body));
      } else {
        throw Exception(
          'Error al crear la encuesta: ${response.statusCode} - ${response.body}',
        );
      }
    } catch (e) {
      throw Exception('Error al crear la encuesta: $e');
    } finally {
      client.close();
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

    final participationResponse = await http.post(
      Uri.parse('$_baseUrl/participations/'),
      headers: {
        'Authorization': 'Bearer $token',
        'Content-Type': 'application/json',
      },
      body: json.encode({'encuesta_id': surveyId, 'completada': false}),
    );

    if (participationResponse.statusCode != 201) {
      throw Exception(
        'Error al crear la participación: ${participationResponse.body}',
      );
    }

    final participation = SurveyParticipation.fromJson(
      json.decode(participationResponse.body),
    );

    for (final answer in answers) {
      final response = await http.post(
        Uri.parse('$_baseUrl/responses/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
        body: json.encode({
          ...answer.toJson(),
          'participacion_id': participation.id,
          'pregunta_id': answer.preguntaId,
          'opcion_id': answer.opcionId,
        }),
      );

      if (response.statusCode != 201) {
        throw Exception('Error al crear respuesta: ${response.body}');
      }
    }

    return participation;
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

  // Obtener todas las participaciones del usuario
  Future<List<SurveyParticipation>> getUserParticipations() async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final response = await http.get(
      Uri.parse('$_baseUrl/participations/'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> jsonList = json.decode(response.body);
      return jsonList
          .map((json) => SurveyParticipation.fromJson(json))
          .toList();
    } else {
      throw Exception('Error al obtener las participaciones');
    }
  }

  Future<Map<String, dynamic>> getSurveyStats(int surveyId) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    try {
      final response = await http.get(
        Uri.parse('$_surveysUrl/$surveyId/stats'),
        headers: {'Authorization': 'Bearer $token'},
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        return {
          'questionStats': data['question_stats'] ?? {},
          'totalResponses': data['total_responses'] ?? 0,
        };
      } else {
        throw Exception(
          'Error al obtener estadísticas: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error al obtener estadísticas: $e');
    }
  }

  Future<SurveyParticipation> getParticipationDetails(
    int participationId,
  ) async {
    final token = ref.read(getTokenAccesoProvider);
    if (token == null) throw Exception('No autorizado');

    final response = await http.get(
      Uri.parse('$_baseUrl/participations/$participationId'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return SurveyParticipation.fromJson(data);
    } else if (response.statusCode == 404) {
      throw Exception('Participación no encontrada o no pertenece al usuario');
    } else {
      throw Exception('Error al obtener los detalles de la participación');
    }
  }
}
