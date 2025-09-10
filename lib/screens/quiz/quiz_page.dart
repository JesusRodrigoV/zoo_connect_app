import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart';
import 'package:http/http.dart' as http;
import 'package:zoo_connect_app/providers/quiz/quiz_state_provider.dart';
import 'package:zoo_connect_app/shared/quiz/quiz_question.dart';
import 'package:zoo_connect_app/shared/widgets/custom_loader.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key});

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  void _onAnswerSelected(String selectedAnswer) {
    ref.read(quizStateProvider.notifier).answerQuestion(_currentIndex, selectedAnswer);

    Future.delayed(const Duration(milliseconds: 1500), () {
      final questions = ref.read(quizQuestionsProvider).value!;
      if (_currentIndex < questions.length - 1) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      } else {
        _showQuizCompletedDialog();
      }
    });
  }

  void _onPageChanged(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  void _showQuizCompletedDialog() {
    final quizState = ref.read(quizStateProvider);
    final totalQuestions = ref.read(quizQuestionsProvider).value!.length;

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Terminado!'),
        content: Text('Puntaje es: ${quizState.score} de $totalQuestions'),
        actions: <Widget>[
          TextButton(
            child: const Text('OK'),
            onPressed: () {
              Navigator.of(ctx).pop();
              Navigator.of(context).pop();
              ref.read(quizStateProvider.notifier).resetState();
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final quizQuestions = ref.watch(quizQuestionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${_currentIndex + 1} / ${quizQuestions.value?.length ?? 0}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          )
        ],
      ),
      body: quizQuestions.when(
        data: (questions) {
          if (questions.isEmpty) {
            return const Center(child: Text('No se encontraron preguntas.'));
          }

          return PageView.builder(
            controller: _pageController,
            itemCount: questions.length,
            onPageChanged: _onPageChanged,
            itemBuilder: (context, index) {
              final question = questions[index];
              return QuizQuestionCard(
                question: question,
                index: index,
                onAnswered: _onAnswerSelected,
              );
            },
          );
        },
        loading: () => customLoader(),
        error: (error, stack) => _buildErrorWidget(error, ref),
      ),
    );
  }

  Widget _buildErrorWidget(Object error, WidgetRef ref) {
    String errorMessage = 'Ocurrió un error inesperado.';
    if (error is http.ClientException) {
      errorMessage = 'Error de conexión. Por favor, verifica tu internet.';
    } else if (error.toString().contains('Fallo al cargar las preguntas')) {
      errorMessage = 'No se pudieron cargar las preguntas. Inténtalo de nuevo.';
    } else if (error.toString().contains('Error en la API: Código')) {
      errorMessage = 'No hay suficientes preguntas para la configuración seleccionada. Por favor, intenta con otra configuración.';
    }

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.error_outline, color: Colors.red, size: 60),
            const SizedBox(height: 16),
            Text(
              errorMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 16, color: Colors.red),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                ref.invalidate(quizQuestionsProvider);
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}