import 'package:freezed_annotation/freezed_annotation.dart';

part 'survey_participation.freezed.dart';
part 'survey_participation.g.dart';

@freezed
abstract class SurveyAnswer with _$SurveyAnswer {
  const factory SurveyAnswer({
    @JsonKey(name: 'id_respuesta') int? id,
    @JsonKey(name: 'pregunta_id') required int preguntaId,
    @JsonKey(name: 'opcion_id') int? opcionId,
    @JsonKey(name: 'respuesta_texto') String? respuestaTexto,
  }) = _SurveyAnswer;

  factory SurveyAnswer.fromJson(Map<String, dynamic> json) =>
      _$SurveyAnswerFromJson(json);
}

@freezed
abstract class SurveyParticipation with _$SurveyParticipation {
  const factory SurveyParticipation({
    @JsonKey(name: 'id_participacion') int? id,
    @JsonKey(name: 'encuesta_id') required int encuestaId,
    @JsonKey(name: 'usuario_id') required int usuarioId,
    @JsonKey(name: 'fecha_participacion') required DateTime fechaParticipacion,
    @Default([]) List<SurveyAnswer> respuestas,
  }) = _SurveyParticipation;

  factory SurveyParticipation.fromJson(Map<String, dynamic> json) =>
      _$SurveyParticipationFromJson(json);
}
