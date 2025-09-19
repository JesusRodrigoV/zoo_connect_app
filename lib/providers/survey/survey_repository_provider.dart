import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/repositories/survey_repository.dart';

final surveyRepositoryProvider = Provider<SurveyRepository>((ref) {
  return SurveyRepository(ref);
});
