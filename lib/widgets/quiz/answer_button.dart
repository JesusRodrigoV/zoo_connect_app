import 'package:flutter/material.dart';
import 'package:html_unescape/html_unescape.dart';

class AnswerButton extends StatelessWidget {
  final String answer;
  final int index;
  final bool isAnswered;
  final String? userSelectedAnswer;
  final String correctAnswer;
  final VoidCallback? onPressed;

  const AnswerButton({
    super.key,
    required this.answer,
    required this.index,
    required this.isAnswered,
    required this.userSelectedAnswer,
    required this.correctAnswer,
    this.onPressed,
  });

  Color _getButtonColor() {
    if (!isAnswered) {
      return Colors.blue.withAlpha(200);
    }
    if (answer == correctAnswer) {
      return Colors.green.shade600;
    }
    if (answer == userSelectedAnswer && userSelectedAnswer != correctAnswer) {
      return Colors.red.shade600;
    }
    return Colors.grey.shade400;
  }

  Icon? _getButtonIcon() {
    if (!isAnswered) return null;
    
    if (answer == correctAnswer) {
      return const Icon(Icons.check_circle, color: Colors.green, size: 24);
    }
    if (answer == userSelectedAnswer && userSelectedAnswer != correctAnswer) {
      return const Icon(Icons.cancel, color: Colors.red, size: 24);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final unescape = HtmlUnescape();
    
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6.0),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        child: Material(
          elevation: isAnswered ? 2 : 4,
          borderRadius: BorderRadius.circular(16),
          child: ElevatedButton(
            onPressed: isAnswered ? null : onPressed,
            style: ElevatedButton.styleFrom(
              backgroundColor: _getButtonColor(),
              padding: const EdgeInsets.symmetric(
                vertical: 20,
                horizontal: 16,
              ),
              textStyle: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
              foregroundColor: Colors.white,
              elevation: 0,
              shadowColor: Colors.transparent,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
            child: Row(
              children: [
                // Número de opción
                Container(
                  width: 32,
                  height: 32,
                  decoration: BoxDecoration(
                    color: Colors.white.withAlpha(51), // 0.2 * 255
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Center(
                    child: Text(
                      String.fromCharCode(65 + index), // A, B, C, D
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                
                Expanded(
                  child: Text(
                    unescape.convert(answer),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                
                // Icono de resultado
                if (isAnswered && _getButtonIcon() != null) ...[
                  const SizedBox(width: 12),
                  _getButtonIcon()!,
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}