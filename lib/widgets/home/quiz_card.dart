import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart';
import 'package:zoo_connect_app/screens/quiz/quiz_page.dart';

class QuizCard extends ConsumerWidget {
  const QuizCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25),
        color: colors.primary,
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 3,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "¡Ponte a prueba!",
                        style: TextStyle(
                          color: colors.onPrimary,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.start,
                      ),
                      SizedBox(height: 15),
                      Text(
                        "¿Cuantos sabes de animales? Realiza nuestros quizzes y descúbrelo",
                        style: TextStyle(color: colors.onPrimary),
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.left,
                      ),
                      SizedBox(height: 15),
                      ElevatedButton(
                        onPressed: () {
                          ref
                              .read(quizConfigProvider.notifier)
                              .setRandomConfig();
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => const QuizPage(),
                            ),
                          );
                        },
                        child: Text(
                          "Jugar",
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(width: 15),
                Icon(Icons.quiz_outlined, color: colors.onPrimary, size: 64),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
