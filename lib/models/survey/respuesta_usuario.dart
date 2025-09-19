import 'package:freezed_annotation/freezed_annotation.dart';

part 'respuesta_usuario.freezed.dart';
part 'respuesta_usuario.g.dart';

@freezed
abstract class RespuestaUsuario with _$RespuestaUsuario {
  const factory RespuestaUsuario({
    @JsonKey(name: 'id_respuesta') required int id,
    @JsonKey(name: 'participacion_id') required int participacionId,
    @JsonKey(name: 'pregunta_id') required int preguntaId,
    @JsonKey(name: 'opcion_id') int? opcionId,
    @JsonKey(name: 'respuesta_texto') String? respuestaTexto,
  }) = _RespuestaUsuario;

  factory RespuestaUsuario.fromJson(Map<String, dynamic> json) =>
      _$RespuestaUsuarioFromJson(json);
}
