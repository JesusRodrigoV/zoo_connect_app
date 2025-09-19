// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'respuesta_usuario.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_RespuestaUsuario _$RespuestaUsuarioFromJson(Map<String, dynamic> json) =>
    _RespuestaUsuario(
      id: (json['id_respuesta'] as num).toInt(),
      participacionId: (json['participacion_id'] as num).toInt(),
      preguntaId: (json['pregunta_id'] as num).toInt(),
      opcionId: (json['opcion_id'] as num?)?.toInt(),
      respuestaTexto: json['respuesta_texto'] as String?,
    );

Map<String, dynamic> _$RespuestaUsuarioToJson(_RespuestaUsuario instance) =>
    <String, dynamic>{
      'id_respuesta': instance.id,
      'participacion_id': instance.participacionId,
      'pregunta_id': instance.preguntaId,
      'opcion_id': instance.opcionId,
      'respuesta_texto': instance.respuestaTexto,
    };
