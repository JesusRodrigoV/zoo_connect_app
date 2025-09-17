import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter_survey/flutter_survey.dart';

part 'encuesta.freezed.dart';
part 'encuesta.g.dart';

@freezed
abstract class Encuesta with _$Encuesta {
  const factory Encuesta({
    required String id,
    required String titulo,
    required String descripcion,
    required List<Question> preguntas,
    @Default(false) bool publicada,
    required DateTime fechaCreacion,
  }) = _Encuesta;

  factory Encuesta.fromJson(Map<String, dynamic> json) =>
      _$EncuestaFromJson(json);
}
