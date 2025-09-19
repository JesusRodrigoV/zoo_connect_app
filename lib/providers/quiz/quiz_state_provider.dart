import 'package:flutter_riverpod/flutter_riverpod.dart';
//import 'package:zoo_connect_app/providers/quiz/quiz_question_provider.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart';
import 'package:zoo_connect_app/providers/quiz/ai_questions_provider.dart';

class QuizState {
  final Map<int, String> userAnswers;
  final int score;
  final int maxPossibleScore;

  QuizState({
    required this.userAnswers,
    this.score = 0,
    this.maxPossibleScore = 0,
  });

  QuizState copyWith({
    Map<int, String>? userAnswers,
    int? score,
    int? maxPossibleScore,
  }) {
    return QuizState(
      userAnswers: userAnswers ?? this.userAnswers,
      score: score ?? this.score,
      maxPossibleScore: maxPossibleScore ?? this.maxPossibleScore,
    );
  }

  double get percentageScore =>
      maxPossibleScore > 0 ? (score / maxPossibleScore) * 100 : 0;
}

class QuizStateNotifier extends StateNotifier<QuizState> {
  QuizStateNotifier(this.ref) : super(QuizState(userAnswers: {}));
  final Ref ref;

  int _getPointsForDifficulty(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'easy':
        return 5;
      case 'medium':
        return 10;
      case 'hard':
        return 15;
      default:
        return 5;
    }
  }

  void initializeQuiz() {
    final quizQuestions = ref.read(aiQuizQuestionsProvider);
    final quizConfig = ref.read(quizConfigProvider);
    final totalPossiblePoints =
        quizQuestions.questions.length *
        _getPointsForDifficulty(quizConfig.difficulty);

    state = QuizState(
      userAnswers: {},
      score: 0,
      maxPossibleScore: totalPossiblePoints,
    );
  }

  void answerQuestion(int index, String selectedAnswer) {
    if (state.userAnswers.containsKey(index)) return;

    final quizQuestions = ref.read(aiQuizQuestionsProvider);
    if (index >= quizQuestions.questions.length) return;

    final correctAnswer = quizQuestions.questions[index].correctAnswer;
    final quizConfig = ref.read(quizConfigProvider);
    final pointsForQuestion = _getPointsForDifficulty(quizConfig.difficulty);

    final newUserAnswers = Map<int, String>.from(state.userAnswers);
    newUserAnswers[index] = selectedAnswer;

    final newScore =
        state.score + (selectedAnswer == correctAnswer ? pointsForQuestion : 0);

    state = state.copyWith(userAnswers: newUserAnswers, score: newScore);
  }

  void resetState() {
    state = QuizState(userAnswers: {}, score: 0, maxPossibleScore: 0);
  }
}

final quizStateProvider = StateNotifierProvider<QuizStateNotifier, QuizState>((
  ref,
) {
  return QuizStateNotifier(ref);
});
