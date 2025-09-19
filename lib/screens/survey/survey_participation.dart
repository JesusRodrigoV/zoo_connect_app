import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zoo_connect_app/models/survey/survey_participation.dart';
import 'package:zoo_connect_app/models/survey/survey_question.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';

class SurveyParticipationPage extends ConsumerStatefulWidget {
  final int surveyId;

  const SurveyParticipationPage({super.key, required this.surveyId});

  @override
  ConsumerState<SurveyParticipationPage> createState() =>
      _SurveyParticipationPageState();
}

class _SurveyParticipationPageState
    extends ConsumerState<SurveyParticipationPage> {
  final _answers = <SurveyAnswer>[];
  final _textControllers = <int, TextEditingController>{};

  @override
  void initState() {
    super.initState();
    Future.microtask(
      () => ref.read(surveyProvider.notifier).selectSurvey(widget.surveyId),
    );
  }

  @override
  void dispose() {
    for (final controller in _textControllers.values) {
      controller.dispose();
    }
    super.dispose();
  }

  void _selectOption(SurveyQuestion question, int optionId) {
    setState(() {
      _answers.removeWhere((a) => a.preguntaId == question.id);
      _answers.add(SurveyAnswer(preguntaId: question.id!, opcionId: optionId));
    });
  }

  void _updateTextAnswer(SurveyQuestion question, String text) {
    setState(() {
      _answers.removeWhere((a) => a.preguntaId == question.id);
      _answers.add(
        SurveyAnswer(preguntaId: question.id!, respuestaTexto: text),
      );
    });
  }

  Future<void> _submitSurvey() async {
    final survey = ref.read(surveyProvider).selectedSurvey;
    if (survey == null) return;

    // Verificar que todas las preguntas estén respondidas
    for (final question in survey.preguntas) {
      final answer = _answers.firstWhere(
        (a) => a.preguntaId == question.id,
        orElse: () => SurveyAnswer(preguntaId: question.id!),
      );

      if (question.type == 'opcion_unica' && answer.opcionId == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor responde la pregunta: ${question.text}'),
          ),
        );
        return;
      }

      if (question.type == 'texto' &&
          (answer.respuestaTexto == null ||
              answer.respuestaTexto!.trim().isEmpty)) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Por favor responde la pregunta: ${question.text}'),
          ),
        );
        return;
      }
    }

    try {
      await ref
          .read(surveyProvider.notifier)
          .participateInSurvey(survey.id!, _answers);
      if (mounted) {
        Navigator.of(context).pop();
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Error: $e')));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final surveyState = ref.watch(surveyProvider);
    final survey = surveyState.selectedSurvey;
    final dateFormat = DateFormat('dd/MM/yyyy');

    if (surveyState.isLoading) {
      return const Scaffold(body: Center(child: CustomLoader()));
    }

    if (survey == null) {
      return const Scaffold(
        body: Center(child: Text('No se encontró la encuesta')),
      );
    }

    if (surveyState.error != null) {
      return Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text('Error: ${surveyState.error}'),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () {
                  ref
                      .read(surveyProvider.notifier)
                      .selectSurvey(widget.surveyId);
                },
                child: const Text('Reintentar'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Responder Encuesta'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(survey.titulo, style: theme.textTheme.headlineSmall),
            const SizedBox(height: 8),
            Text(survey.descripcion),
            const SizedBox(height: 16),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16),
                const SizedBox(width: 4),
                Text(
                  'Disponible hasta el ${dateFormat.format(survey.fechaFin)}',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
            const SizedBox(height: 24),
            ...survey.preguntas.map((question) {
              return Card(
                margin: const EdgeInsets.only(bottom: 16),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(question.text, style: theme.textTheme.titleMedium),
                      const SizedBox(height: 16),
                      if (question.type == 'opcion_unica') ...[
                        ...question.opciones.map((option) {
                          final isSelected = _answers.any(
                            (a) =>
                                a.preguntaId == question.id &&
                                a.opcionId == option.id,
                          );
                          return RadioListTile(
                            value: true,
                            groupValue: isSelected,
                            title: Text(option.text),
                            onChanged: (_) {
                              _selectOption(question, option.id!);
                            },
                          );
                        }),
                      ] else if (question.type == 'texto') ...[
                        TextField(
                          controller: _textControllers.putIfAbsent(
                            question.id!,
                            () => TextEditingController(
                              text: _answers
                                  .firstWhere(
                                    (a) => a.preguntaId == question.id,
                                    orElse: () =>
                                        SurveyAnswer(preguntaId: question.id!),
                                  )
                                  .respuestaTexto,
                            ),
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Escribe tu respuesta aquí',
                            border: OutlineInputBorder(),
                          ),
                          maxLines: 3,
                          onChanged: (text) {
                            _updateTextAnswer(question, text);
                          },
                        ),
                      ],
                    ],
                  ),
                ),
              );
            }),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _submitSurvey,
                child: const Text('Enviar Respuestas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
