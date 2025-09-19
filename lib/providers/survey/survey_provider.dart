import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/survey/survey_notifier.dart';
import 'package:zoo_connect_app/providers/survey/survey_state.dart';
import 'package:zoo_connect_app/repositories/survey_repository.dart';

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  return SurveyRepository(ref);
});

final surveyProvider = StateNotifierProvider<SurveyNotifier, SurveyState>((
  ref,
) {
  final repository = ref.watch(surveyRepositoryProvider);
  return SurveyNotifier(repository: repository);
});
