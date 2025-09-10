import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:zoo_connect_app/models/quiz/quiz.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_state_provider.dart';

class QuizQuestionCard extends ConsumerStatefulWidget {
  final Quiz question;
  final int index;
  final void Function(String selectedAnswer) onAnswered;

  const QuizQuestionCard({
    super.key,
    required this.question,
    required this.index,
    required this.onAnswered,
  });

  @override
  ConsumerState<QuizQuestionCard> createState() => _QuizQuestionCardState();
}

class _QuizQuestionCardState extends ConsumerState<QuizQuestionCard> {
  late List<String> _shuffledAnswers;

  @override
  void initState() {
    super.initState();
    // Mezclar las respuestas una sola vez al inicializar el estado
    _shuffledAnswers = List<String>.from(widget.question.incorrectAnswers);
    _shuffledAnswers.add(widget.question.correctAnswer);
    _shuffledAnswers.shuffle();
  }

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    final quizState = ref.watch(quizStateProvider);
    final userSelectedAnswer = quizState.userAnswers[widget.index];
    final isAnswered = userSelectedAnswer != null;

    Color getButtonColor(String answer) {
      if (!isAnswered) {
        return Colors.blue;
      }
      if (answer == widget.question.correctAnswer) {
        return Colors.green;
      }
      if (answer == userSelectedAnswer &&
          userSelectedAnswer != widget.question.correctAnswer) {
        return Colors.red;
      }
      return Colors.grey.shade400;
    }

    Icon? getButtonIcon(String answer) {
      if (!isAnswered) {
        return null;
      }
      if (answer == widget.question.correctAnswer) {
        return const Icon(Icons.check, color: Colors.white);
      }
      if (answer == userSelectedAnswer &&
          userSelectedAnswer != widget.question.correctAnswer) {
        return const Icon(Icons.close, color: Colors.white);
      }
      return null;
    }

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              unescape.convert(widget.question.question),
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            ..._shuffledAnswers.map((answer) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: ElevatedButton(
                  onPressed: isAnswered
                      ? null
                      : () => widget.onAnswered(answer),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: getButtonColor(answer),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    textStyle: const TextStyle(fontSize: 16),
                    foregroundColor: Colors.white,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(unescape.convert(answer)),
                      if (isAnswered && getButtonIcon(answer) != null) ...[
                        const SizedBox(width: 8),
                        getButtonIcon(answer)!,
                      ],
                    ],
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
