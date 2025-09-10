import 'dart:math';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:zoo_connect_app/models/quiz/quiz.dart';


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

// 2. StateNotifier para manejar la configuración del quiz
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

final quizConfigProvider = StateNotifierProvider<QuizConfigNotifier, QuizConfig>((ref) {
  return QuizConfigNotifier();
});

// Proveedor para obtener el token de sesión
final sessionTokenProvider = FutureProvider.autoDispose<String?>((ref) async {
  final tokenUrl = 'https://opentdb.com/api_token.php?command=request';
  try {
    final response = await http.get(Uri.parse(tokenUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['response_code'] == 0) {
        return data['token'];
      }
    }
  } catch (e) {
    print('Error al obtener el token de sesión: $e');
  }
  return null;
});

// 3. Proveedor para las preguntas de la API
final quizQuestionsProvider = FutureProvider.autoDispose<List<Quiz>>((ref) async {
  final config = ref.watch(quizConfigProvider);
  final sessionToken = await ref.watch(sessionTokenProvider.future);
  String apiUrl = 'https://opentdb.com/api.php?amount=${config.amount}&category=27&difficulty=${config.difficulty}';

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
        return results.map((json) => Quiz.fromJson(json)).toList();
      } else {
        throw Exception('Error en la API: Código $responseCode');
      }
    } else {
      throw Exception('Fallo al cargar las preguntas. Código: ${response.statusCode}');
    }
  } catch (e) {
    throw Exception('Error de conexión: $e');
  }
});