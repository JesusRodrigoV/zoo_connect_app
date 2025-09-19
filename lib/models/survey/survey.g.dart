// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'survey.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Survey _$SurveyFromJson(Map<String, dynamic> json) => _Survey(
  id: (json['id_encuesta'] as num?)?.toInt(),
  titulo: json['titulo'] as String,
  descripcion: json['descripcion'] as String,
  fechaInicio: const ISODateTimeConverter().fromJson(
    json['fecha_inicio'] as String,
  ),
  fechaFin: const ISODateTimeConverter().fromJson(json['fecha_fin'] as String),
  isActive: json['activa'] as bool? ?? true,
  preguntas:
      (json['preguntas'] as List<dynamic>?)
          ?.map((e) => SurveyQuestion.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
);

Map<String, dynamic> _$SurveyToJson(_Survey instance) => <String, dynamic>{
  'id_encuesta': instance.id,
  'titulo': instance.titulo,
  'descripcion': instance.descripcion,
  'fecha_inicio': const ISODateTimeConverter().toJson(instance.fechaInicio),
  'fecha_fin': const ISODateTimeConverter().toJson(instance.fechaFin),
  'activa': instance.isActive,
  'preguntas': instance.preguntas,
};
