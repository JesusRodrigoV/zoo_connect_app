import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zoo_connect_app/models/quiz/quiz.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_providers.dart';

class QuizConfig {
  final int amount;
  final String difficulty;
  QuizConfig({required this.amount, required this.difficulty});

  QuizConfig copyWith({int? amount, String? difficulty}) {
    return QuizConfig(
      amount: amount ?? this.amount,
      difficulty: difficulty ?? this.difficulty,
    );
  }
}

class QuizConfigNotifier extends StateNotifier<QuizConfig> {
  QuizConfigNotifier() : super(QuizConfig(amount: 10, difficulty: 'easy'));

  void setAmount(int amount) {
    state = state.copyWith(amount: amount);
  }

  void setDifficulty(String difficulty) {
    state = state.copyWith(difficulty: difficulty);
  }

  void setRandomConfig() {
    final random = Random();
    final randomAmount = (random.nextInt(3) + 1) * 5;
    final randomDifficulty = ['easy', 'medium', 'hard'][random.nextInt(3)];
    state = state.copyWith(amount: randomAmount, difficulty: randomDifficulty);
  }
}

final quizConfigProvider =
    StateNotifierProvider<QuizConfigNotifier, QuizConfig>((ref) {
      return QuizConfigNotifier();
    });

class QuizQuestionsState {
  final List<Quiz> questions;
  final bool isLoading;
  final String? error;

  QuizQuestionsState({
    this.questions = const [],
    this.isLoading = false,
    this.error,
  });

  QuizQuestionsState copyWith({
    List<Quiz>? questions,
    bool? isLoading,
    String? error,
  }) {
    return QuizQuestionsState(
      questions: questions ?? this.questions,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

class QuizQuestionsNotifier extends StateNotifier<QuizQuestionsState> {
  final Ref ref;

  QuizQuestionsNotifier(this.ref) : super(QuizQuestionsState());

  Future<void> fetchQuestions() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    final config = ref.read(quizConfigProvider);
    final sessionToken = await ref.read(sessionTokenProvider.future);

    String apiUrl =
        'https://opentdb.com/api.php?amount=${config.amount}&category=27&difficulty=${config.difficulty}';

    if (sessionToken != null) {
      apiUrl += '&token=$sessionToken';
    }

    try {
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final int responseCode = data['response_code'];

        if (responseCode == 0) {
          final List results = data['results'];
          final fetchedQuestions = results
              .map((json) => Quiz.fromJson(json))
              .toList();
          state = state.copyWith(questions: fetchedQuestions, isLoading: false);
        } else {
          String errorMessage;
          if (responseCode == 1) {
            errorMessage =
                'No hay suficientes preguntas para la configuración seleccionada. Intenta con otra configuración.';
          } else if (responseCode == 2) {
            errorMessage = 'Parámetros inválidos en la API.';
          } else if (responseCode == 3 || responseCode == 4) {
            errorMessage =
                'El token de sesión ha expirado o no es válido. Reinicia la aplicación para obtener uno nuevo.';
          } else {
            errorMessage = 'Error en la API: Código $responseCode';
          }
          state = state.copyWith(error: errorMessage, isLoading: false);
        }
      } else {
        state = state.copyWith(
          error:
              'Fallo al cargar las preguntas. Código: ${response.statusCode}',
          isLoading: false,
        );
      }
    } on http.ClientException {
      state = state.copyWith(
        error: 'Error de conexión. Por favor, verifica tu internet.',
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        error: 'Ocurrió un error inesperado al cargar las preguntas.',
        isLoading: false,
      );
    }
  }
}
