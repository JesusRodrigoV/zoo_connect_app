import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/quiz/quiz.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

String _geminiApiKey = dotenv.env["GEMINI_API_KEY"] ?? " ";

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

class AiQuizQuestionsNotifier extends StateNotifier<QuizQuestionsState> {
  final Ref ref;

  AiQuizQuestionsNotifier(this.ref) : super(QuizQuestionsState());

  Future<void> fetchQuestions() async {
    if (state.isLoading) return;

    state = state.copyWith(isLoading: true, error: null);

    final config = ref.read(quizConfigProvider);

    final prompt =
        """
      Genera ${config.amount} preguntas de trivia sobre animales. 
      Cada pregunta debe tener una respuesta correcta y 3 respuestas incorrectas. 
      Las preguntas deben tener una dificultad de ${config.difficulty}. 
      El formato de la respuesta debe ser una lista de objetos JSON, 
      cada uno con las claves 'question', 'correct_answer', 
      y 'incorrect_answers' (una lista de strings). No incluyas nada más en la respuesta, ni saludos ni despedidas, solo el json.
    """;

    const apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          'Content-Type': 'application/json',
          'x-goog-api-key': _geminiApiKey,
        },
        body: jsonEncode({
          'contents': [
            {
              'parts': [
                {'text': prompt},
              ],
            },
          ],
        }),
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final generatedText =
            data['candidates'][0]['content']['parts'][0]['text'] as String;

        final cleanText = generatedText
            .replaceAll('```json\n', '')
            .replaceAll('\n```', '')
            .trim();

        final List<dynamic> results = json.decode(cleanText);

        final fetchedQuestions = results.map((json) {
          return Quiz.fromJson({
            ...json,
            'type': 'ai_generated',
            'difficulty': config.difficulty,
            'category': 'AI-generated Animal Quiz',
          });
        }).toList();

        state = state.copyWith(questions: fetchedQuestions, isLoading: false);
      } else {
        state = state.copyWith(
          error:
              'Fallo al cargar las preguntas de la IA. Código: ${response.statusCode}',
          isLoading: false,
        );
      }
    } catch (e) {
      state = state.copyWith(
        error:
            'Ocurrió un error inesperado al cargar las preguntas de la IA: $e',
        isLoading: false,
      );
    }
  }
}

final aiQuizQuestionsProvider =
    StateNotifierProvider<AiQuizQuestionsNotifier, QuizQuestionsState>((ref) {
      final notifier = AiQuizQuestionsNotifier(ref);

      ref.listen(quizConfigProvider, (prev, next) {
        notifier.fetchQuestions();
      });

      return notifier;
    });
