import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoo_connect_app/models/survey/survey_option.dart';

part 'survey_question.freezed.dart';
part 'survey_question.g.dart';

@freezed
abstract class SurveyQuestion with _$SurveyQuestion {
  const factory SurveyQuestion({
    @JsonKey(name: 'id_pregunta') int? id,
    @JsonKey(name: 'texto_pregunta') required String text,
    @JsonKey(name: 'tipo_pregunta') required String type,
    required int orden,
    @Default([]) List<SurveyOption> opciones,
  }) = _SurveyQuestion;

  factory SurveyQuestion.fromJson(Map<String, dynamic> json) =>
      _$SurveyQuestionFromJson(json);
}
