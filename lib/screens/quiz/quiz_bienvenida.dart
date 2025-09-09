import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz_config_provider.dart';
import 'package:zoo_connect_app/screens/quiz/quiz_page.dart';

class QuizBienvenida extends ConsumerWidget {
  const QuizBienvenida({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final quizConfigNotifier = ref.watch(quizConfigProvider.notifier);
    final quizConfig = ref.watch(quizConfigProvider);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                "¡Bienvenido al Quiz!",
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 50),
              ElevatedButton(
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => const QuizPage()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 40,
                    vertical: 20,
                  ),
                  textStyle: const TextStyle(fontSize: 18),
                ),
                child: const Text('Iniciar Quiz'),
              ),
              const SizedBox(height: 20),
              ExpansionTile(
                title: const Text('Configuración Avanzada'),
                children: [
                  ListTile(
                    title: const Text('Cantidad de Preguntas'),
                    trailing: DropdownButton<int>(
                      value: quizConfig.amount,
                      items:
                          List.generate(5, (index) => (index + 1) * 10).map((
                            int amount,
                          ) {
                            return DropdownMenuItem<int>(
                              value: amount,
                              child: Text('$amount'),
                            );
                          }).toList(),
                      onChanged: (int? newValue) {
                        if (newValue != null) {
                          quizConfigNotifier.setAmount(newValue);
                        }
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Dificultad'),
                    trailing: DropdownButton<String>(
                      value: quizConfig.difficulty,
                      items:
                          ['easy', 'medium', 'hard'].map((String difficulty) {
                            return DropdownMenuItem<String>(
                              value: difficulty,
                              child: Text(difficulty),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          quizConfigNotifier.setDifficulty(newValue);
                        }
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
