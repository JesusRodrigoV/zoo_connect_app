import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/models/quiz/quiz.dart';
import 'package:zoo_connect_app/providers/quiz/feedback_provider.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_state_provider.dart';
import 'package:zoo_connect_app/widgets/quiz/answer_button.dart';
import 'package:zoo_connect_app/widgets/quiz/edge_effect_controller.dart';
import 'package:zoo_connect_app/widgets/quiz/edge_effect_overlay.dart';
import 'package:zoo_connect_app/widgets/quiz/question_card.dart';

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

class _QuizQuestionCardState extends ConsumerState<QuizQuestionCard>
    with TickerProviderStateMixin {
  late List<String> _shuffledAnswers;
  late EdgeEffectController _effectController;

  @override
  void initState() {
    super.initState();
    _initializeAnswers();
    _effectController = EdgeEffectController(vsync: this);
  }

  void _initializeAnswers() {
    _shuffledAnswers = List<String>.from(widget.question.incorrectAnswers);
    _shuffledAnswers.add(widget.question.correctAnswer);
    _shuffledAnswers.shuffle();
  }

  @override
  void dispose() {
    _effectController.dispose();
    super.dispose();
  }

  Future<void> _handleAnswer(String answer) async {
    final isCorrect = answer == widget.question.correctAnswer;
    
    // Trigger visual effect
    _effectController.triggerEffect(isCorrect);
    
    // Provide feedback
    final feedbackService = ref.read(feedbackServiceProvider);
    if (isCorrect) {
      await feedbackService.provideCorrectFeedback();
    } else {
      await feedbackService.provideIncorrectFeedback();
    }
    
    // Notify parent
    widget.onAnswered(answer);
  }

  @override
  Widget build(BuildContext context) {
    final quizState = ref.watch(quizStateProvider);
    final userSelectedAnswer = quizState.userAnswers[widget.index];
    final isAnswered = userSelectedAnswer != null;

    return AnimatedBuilder(
      animation: Listenable.merge([
        _effectController.edgeLightAnimation,
        _effectController.pulseAnimation
      ]),
      builder: (context, child) {
        return Stack(
          children: [
            // Main content with pulse effect
            Transform.scale(
              scale: _effectController.pulseAnimation.value,
              child: _QuizContent(
                question: widget.question.question,
                answers: _shuffledAnswers,
                isAnswered: isAnswered,
                userSelectedAnswer: userSelectedAnswer,
                correctAnswer: widget.question.correctAnswer,
                onAnswerPressed: _handleAnswer,
              ),
            ),
            
            // Edge effect overlay
            EdgeEffectOverlay(controller: _effectController),
          ],
        );
      },
    );
  }
}

class _QuizContent extends StatelessWidget {
  final String question;
  final List<String> answers;
  final bool isAnswered;
  final String? userSelectedAnswer;
  final String correctAnswer;
  final Future<void> Function(String) onAnswerPressed;

  const _QuizContent({
    required this.question,
    required this.answers,
    required this.isAnswered,
    required this.userSelectedAnswer,
    required this.correctAnswer,
    required this.onAnswerPressed,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Question
            QuestionCard(question: question),
            const SizedBox(height: 32),

            // Answer options
            ...answers.asMap().entries.map((entry) {
              final index = entry.key;
              final answer = entry.value;
              
              return AnswerButton(
                answer: answer,
                index: index,
                isAnswered: isAnswered,
                userSelectedAnswer: userSelectedAnswer,
                correctAnswer: correctAnswer,
                onPressed: () => onAnswerPressed(answer),
              );
            }),
          ],
        ),
      ),
    );
  }
}