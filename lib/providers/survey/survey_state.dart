import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';

part 'survey_state.freezed.dart';

@freezed
abstract class SurveyState with _$SurveyState {
  const factory SurveyState({
    @Default([]) List<Survey> surveys,
    Survey? selectedSurvey,
    @Default(false) bool isLoading,
    String? error,
  }) = _SurveyState;
}
