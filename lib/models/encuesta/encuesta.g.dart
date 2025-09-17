// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'encuesta.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Encuesta _$EncuestaFromJson(Map<String, dynamic> json) => _Encuesta(
  id: json['id'] as String,
  titulo: json['titulo'] as String,
  descripcion: json['descripcion'] as String,
  preguntas: (json['preguntas'] as List<dynamic>)
      .map((e) => Question.fromJson(e as Map<String, dynamic>))
      .toList(),
  publicada: json['publicada'] as bool? ?? false,
  fechaCreacion: DateTime.parse(json['fechaCreacion'] as String),
);

Map<String, dynamic> _$EncuestaToJson(_Encuesta instance) => <String, dynamic>{
  'id': instance.id,
  'titulo': instance.titulo,
  'descripcion': instance.descripcion,
  'preguntas': instance.preguntas,
  'publicada': instance.publicada,
  'fechaCreacion': instance.fechaCreacion.toIso8601String(),
};
