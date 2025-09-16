import 'package:freezed_annotation/freezed_annotation.dart';

part 'encuesta.freezed.dart';
part 'encuesta.g.dart';

@freezed
abstract class Encuesta with _$Encuesta {
  const factory Encuesta({
    required String id,
    required String titulo,
    required String descripcion,
    @JsonKey(name: 'fecha_creacion') required DateTime fechaCreacion,
    required List<String> preguntas,
  }) = _Encuesta;

  factory Encuesta.fromJson(Map<String, dynamic> json) =>
      _$EncuestaFromJson(json);
}
