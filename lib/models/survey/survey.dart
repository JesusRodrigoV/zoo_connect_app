import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoo_connect_app/models/survey/survey_question.dart';
import 'package:zoo_connect_app/models/utils/date_converter.dart';

part 'survey.freezed.dart';
part 'survey.g.dart';

@freezed
abstract class Survey with _$Survey {
  const factory Survey({
    @JsonKey(name: 'id_encuesta') int? id,
    @JsonKey(name: 'titulo') required String titulo,
    @JsonKey(name: 'descripcion') required String descripcion,
    @JsonKey(name: 'fecha_inicio')
    @ISODateTimeConverter()
    required DateTime fechaInicio,
    @JsonKey(name: 'fecha_fin')
    @ISODateTimeConverter()
    required DateTime fechaFin,
    @JsonKey(name: 'activa', defaultValue: true) required bool isActive,
    @Default([]) @JsonKey(name: 'preguntas') List<SurveyQuestion> preguntas,
  }) = _Survey;

  factory Survey.fromJson(Map<String, dynamic> json) => _$SurveyFromJson(json);
}
