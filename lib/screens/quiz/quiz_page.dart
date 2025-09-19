import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz/ai_questions_provider.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_state_provider.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart'
    as config;
import 'package:zoo_connect_app/widgets/quiz/quiz_question.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class QuizPage extends ConsumerStatefulWidget {
  const QuizPage({super.key});

  @override
  ConsumerState<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends ConsumerState<QuizPage> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    Future.microtask(() {
      ref.read(aiQuizQuestionsProvider.notifier).fetchQuestions();
      ref.read(quizStateProvider.notifier).initializeQuiz();
    });
  }

  Future<bool> _onWillPop() async {
    if (ref.read(quizStateProvider).userAnswers.isEmpty) {
      return true; // Si no hay respuestas, permite salir directamente
    }

    return await showDialog<bool>(
          context: context,
          builder: (context) => AlertDialog(
            title: const Text('¿Abandonar Quiz?'),
            content: const Text(
              '¿Estás seguro de que quieres salir? Perderás todo el progreso actual.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(false),
                child: const Text('Cancelar'),
              ),
              FilledButton(
                onPressed: () {
                  ref.read(quizStateProvider.notifier).resetState();
                  Navigator.of(context).pop(true);
                },
                child: const Text('Salir'),
              ),
            ],
          ),
        ) ??
        false;
  }

  void _onAnswerSelected(String selectedAnswer) {
    ref
        .read(quizStateProvider.notifier)
        .answerQuestion(_currentIndex, selectedAnswer);

    Future.delayed(const Duration(milliseconds: 1500), () {
      final questions = ref.read(aiQuizQuestionsProvider).questions;
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

    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Quiz Terminado!'),
        content: Text(
          'Puntaje es: ${quizState.score} de ${quizState.maxPossibleScore}',
        ),
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
    final quizQuestionsState = ref.watch(aiQuizQuestionsProvider);

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        final shouldPop = await _onWillPop();
        if (shouldPop) {
          if (context.mounted) {
            Navigator.of(context).pop();
          }
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "Quiz - ${() {
              final difficulty = ref.watch(config.quizConfigProvider).difficulty;
              final Map<String, String> difficultyMap = {'easy': 'Fácil', 'medium': 'Medio', 'hard': 'Difícil'};
              return difficultyMap[difficulty] ?? 'Desconocido';
            }()}",
          ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(50),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 8.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      const SizedBox(width: 8),
                      Text(
                        '${_currentIndex + 1}/${quizQuestionsState.questions.length}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  /*
                  Row(
                    children: [
                      const Icon(Icons.score, size: 20),
                      const SizedBox(width: 8),
                      Text(
                        'Puntos: ${ref.watch(quizStateProvider).score}/${ref.watch(quizStateProvider).maxPossibleScore}',
                        style: TextStyle(
                          fontSize: 16,
                          color: Theme.of(context).colorScheme.primary,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  */
                ],
              ),
            ),
          ),
        ),
        body: _buildBody(quizQuestionsState),
      ),
    );
  }

  Widget _buildBody(QuizQuestionsState state) {
    if (state.isLoading) {
      return CustomLoader();
    } else if (state.error != null) {
      return _buildErrorWidget(state.error!, ref);
    } else if (state.questions.isEmpty) {
      return const Center(child: Text('No se encontraron preguntas.'));
    } else {
      return PageView.builder(
        controller: _pageController,
        itemCount: state.questions.length,
        onPageChanged: _onPageChanged,
        itemBuilder: (context, index) {
          final question = state.questions[index];
          return QuizQuestionCard(
            question: question,
            index: index,
            onAnswered: _onAnswerSelected,
          );
        },
      );
    }
  }

  Widget _buildErrorWidget(String errorMessage, WidgetRef ref) {
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
                ref.read(aiQuizQuestionsProvider.notifier).fetchQuestions();
              },
              child: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
