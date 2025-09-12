import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart';

class QuizState {
  final Map<int, String> userAnswers;
  final int score;

  QuizState({
    required this.userAnswers,
    this.score = 0,
  });

  QuizState copyWith({Map<int, String>? userAnswers, int? score}) {
    return QuizState(
      userAnswers: userAnswers ?? this.userAnswers,
      score: score ?? this.score,
    );
  }
}

class QuizStateNotifier extends StateNotifier<QuizState> {
  QuizStateNotifier(this.ref) : super(QuizState(userAnswers: {}));
  final Ref ref;

  void answerQuestion(int index, String selectedAnswer) {
    if (state.userAnswers.containsKey(index)) return;

    final quizQuestions = ref.read(quizQuestionsProvider);
    if (index >= quizQuestions.questions.length) return;

    final correctAnswer = quizQuestions.questions[index].correctAnswer;
    
    final newUserAnswers = Map<int, String>.from(state.userAnswers);
    newUserAnswers[index] = selectedAnswer;

    final newScore = state.score + (selectedAnswer == correctAnswer ? 1 : 0);
    
    state = state.copyWith(userAnswers: newUserAnswers, score: newScore);
  }

  void resetState() {
    state = QuizState(userAnswers: {});
  }
}

final quizStateProvider = StateNotifierProvider<QuizStateNotifier, QuizState>((ref) {
  return QuizStateNotifier(ref);
});