import 'package:zoo_connect_app/models/quiz/quiz.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';



class QuizConfig {
  final int amount;
  final String difficulty;
  final String? token;
  QuizConfig({required this.amount, required this.difficulty, this.token});

  QuizConfig copyWith({int? amount, String? difficulty, String? token}) {
    return QuizConfig(
      amount: amount ?? this.amount,
      difficulty: difficulty ?? this.difficulty,
      token: token ?? this.token,
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

  void setToken(String token) {
    state = state.copyWith(token: token);
  }
}

final quizConfigProvider =
    StateNotifierProvider<QuizConfigNotifier, QuizConfig>((ref) {
      return QuizConfigNotifier();
    });

// 3. Proveedor para las preguntas de la API
final quizQuestionsProvider = FutureProvider.autoDispose<List<Quiz>>((
  ref,
) async {
  final config = ref.watch(quizConfigProvider);
  String apiUrl =
      'https://opentdb.com/api.php?amount=${config.amount}&difficulty=${config.difficulty}&type=multiple';

  if (config.token != null) {
    apiUrl += '&token=${config.token}';
  }

  try {
    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      final int responseCode = data['response_code'];

      if (responseCode == 0) {
        final List results = data['results'];
        return results.map((json) => Quiz.fromJson(json)).toList();
      } else {
        // Manejo de errores de la API
        throw Exception('Error en la API: Código $responseCode');
      }
    } else {
      throw Exception(
        'Fallo al cargar las preguntas. Código: ${response.statusCode}',
      );
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
});
