//quiz_bienvenida.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/quiz/quiz_config_provider.dart';
import 'package:zoo_connect_app/screens/quiz/quiz_page.dart';
import 'package:zoo_connect_app/widgets/profile/profile_icon_button.dart';

class QuizBienvenida extends ConsumerStatefulWidget {
  const QuizBienvenida({super.key});

  @override
  ConsumerState<QuizBienvenida> createState() => _QuizBienvenidaState();
}

class _QuizBienvenidaState extends ConsumerState<QuizBienvenida> {
  bool _isAdvancedConfigExpanded = false;

  @override
  Widget build(BuildContext context) {
    final quizConfigNotifier = ref.watch(quizConfigProvider.notifier);
    final quizConfig = ref.watch(quizConfigProvider);

    final difficultyMap = {
      'Fácil': 'easy',
      'Medio': 'medium',
      'Difícil': 'hard',
    };

    return Scaffold(
      appBar: AppBar(
        title: const Text('Quiz'),
        centerTitle: true,
        actions: [ProfileIconButton()],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: SingleChildScrollView(
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
                    if (!_isAdvancedConfigExpanded) {
                      quizConfigNotifier.setRandomConfig();
                    }
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
                  child: const Text('Iniciar'),
                ),
                const SizedBox(height: 20),
                ExpansionTile(
                  title: const Text('Configuración Avanzada'),
                  onExpansionChanged: (isExpanded) {
                    setState(() {
                      _isAdvancedConfigExpanded = isExpanded;
                    });
                  },
                  children: [
                    ListTile(
                      title: const Text('Cantidad de Preguntas'),
                      trailing: DropdownButton<int>(
                        value: quizConfig.amount,
                        items: List.generate(5, (index) => (index + 1) * 5).map(
                          (int amount) {
                            return DropdownMenuItem<int>(
                              value: amount,
                              child: Text('$amount'),
                            );
                          },
                        ).toList(),
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
                        value: difficultyMap.keys.firstWhere(
                          (key) => difficultyMap[key] == quizConfig.difficulty,
                        ),
                        items: difficultyMap.keys.map((String key) {
                          return DropdownMenuItem<String>(
                            value: key,
                            child: Text(key),
                          );
                        }).toList(),
                        onChanged: (String? newValue) {
                          if (newValue != null) {
                            final apiValue = difficultyMap[newValue]!;
                            quizConfigNotifier.setDifficulty(apiValue);
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
      ),
    );
  }
}
