// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Encuesta _$EncuestaFromJson(Map<String, dynamic> json) => _Encuesta(
  id: json['id'] as String,
  titulo: json['titulo'] as String,
  descripcion: json['descripcion'] as String,
  fechaCreacion: DateTime.parse(json['fecha_creacion'] as String),
  preguntas: (json['preguntas'] as List<dynamic>)
      .map((e) => e as String)
      .toList(),
);

Map<String, dynamic> _$EncuestaToJson(_Encuesta instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descripcion': instance.descripcion,
  'fecha_creacion': instance.fechaCreacion.toIso8601String(),
  'preguntas': instance.preguntas,
};
