import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz/ai_questions_provider.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_state_provider.dart';
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
    });
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
    final totalQuestions = ref.read(aiQuizQuestionsProvider).questions.length;

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
    final quizQuestionsState = ref.watch(aiQuizQuestionsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Quiz"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Center(
              child: Text(
                '${_currentIndex + 1}/${quizQuestionsState.questions.length}',
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ),
        ],
      ),
      body: _buildBody(quizQuestionsState),
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
