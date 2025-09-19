// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_participation.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurveyAnswer _$SurveyAnswerFromJson(Map<String, dynamic> json) =>
    _SurveyAnswer(
      id: (json['id_respuesta'] as num?)?.toInt(),
      preguntaId: (json['pregunta_id'] as num).toInt(),
      opcionId: (json['opcion_id'] as num?)?.toInt(),
      respuestaTexto: json['respuesta_texto'] as String?,
    );

Map<String, dynamic> _$SurveyAnswerToJson(_SurveyAnswer instance) =>
    <String, dynamic>{
      'id_respuesta': instance.id,
      'pregunta_id': instance.preguntaId,
      'opcion_id': instance.opcionId,
      'respuesta_texto': instance.respuestaTexto,
    };

_SurveyParticipation _$SurveyParticipationFromJson(Map<String, dynamic> json) =>
    _SurveyParticipation(
      id: (json['id_participacion'] as num?)?.toInt(),
      encuestaId: (json['encuesta_id'] as num).toInt(),
      usuarioId: (json['usuario_id'] as num).toInt(),
      fechaParticipacion: DateTime.parse(json['fecha_participacion'] as String),
      respuestas:
          (json['respuestas'] as List<dynamic>?)
              ?.map((e) => SurveyAnswer.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SurveyParticipationToJson(
  _SurveyParticipation instance,
) => <String, dynamic>{
  'id_participacion': instance.id,
  'encuesta_id': instance.encuestaId,
  'usuario_id': instance.usuarioId,
  'fecha_participacion': instance.fechaParticipacion.toIso8601String(),
  'respuestas': instance.respuestas,
};
