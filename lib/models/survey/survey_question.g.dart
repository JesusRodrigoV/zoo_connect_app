// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey_question.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_SurveyQuestion _$SurveyQuestionFromJson(Map<String, dynamic> json) =>
    _SurveyQuestion(
      id: (json['id_pregunta'] as num?)?.toInt(),
      text: json['texto_pregunta'] as String,
      esOpcionUnica: json['es_opcion_unica'] as bool,
      orden: (json['orden'] as num?)?.toInt(),
      opciones:
          (json['opciones'] as List<dynamic>?)
              ?.map((e) => SurveyOption.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$SurveyQuestionToJson(_SurveyQuestion instance) =>
    <String, dynamic>{
      'id_pregunta': instance.id,
      'texto_pregunta': instance.text,
      'es_opcion_unica': instance.esOpcionUnica,
      'orden': instance.orden,
      'opciones': instance.opciones,
    };
