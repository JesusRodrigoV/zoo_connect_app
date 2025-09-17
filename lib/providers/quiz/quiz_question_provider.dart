import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart';

final quizQuestionsProvider =
    StateNotifierProvider<QuizQuestionsNotifier, QuizQuestionsState>((ref) {
      final notifier = QuizQuestionsNotifier(ref);
      ref.listen(quizConfigProvider, (prev, next) {
        notifier.fetchQuestions();
      });
      return notifier;
    });
