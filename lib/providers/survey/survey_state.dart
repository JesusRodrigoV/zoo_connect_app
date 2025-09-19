import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';

part 'survey_state.freezed.dart';

@freezed
abstract class SurveyState with _$SurveyState {
  const factory SurveyState({
    @Default([]) List<Survey> surveys,
    @Default([]) List<SurveyParticipation> participations,
    Survey? selectedSurvey,
    SurveyParticipation? selectedParticipation,
    @Default([]) List<Map<String, dynamic>> surveyStats,
    Map<String, dynamic>? selectedSurveyStats,
    @Default(false) bool isLoading,
    String? error,
  }) = _SurveyState;
}
