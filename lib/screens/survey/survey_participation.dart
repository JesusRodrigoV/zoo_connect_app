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

  Future<void> _submitSurvey(BuildContext context) async {
    final colors = Theme.of(context).colorScheme;

    final survey = ref.read(surveyProvider).selectedSurvey;
    if (survey == null) return;

    // Validar respuestas
    String? missingQuestion;
    for (final question in survey.preguntas) {
      final answer = _answers.firstWhere(
        (a) => a.preguntaId == question.id,
        orElse: () => SurveyAnswer(preguntaId: question.id!),
      );

      if (question.esOpcionUnica && answer.opcionId == null) {
        missingQuestion = question.text;
        break;
      }

      if (!question.esOpcionUnica &&
          (answer.respuestaTexto == null ||
              answer.respuestaTexto!.trim().isEmpty)) {
        missingQuestion = question.text;
        break;
      }
    }

    if (missingQuestion != null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.warning_amber_rounded, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(
                child: Text('Por favor responde la pregunta: $missingQuestion'),
              ),
            ],
          ),
          backgroundColor: Colors.orange,
          duration: const Duration(seconds: 3),
          behavior: SnackBarBehavior.floating,
        ),
      );
      return;
    }

    // Mostrar diálogo de carga
    if (!mounted) return;
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const Center(
        child: Card(
          child: Padding(
            padding: EdgeInsets.all(16.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Enviando respuestas...'),
              ],
            ),
          ),
        ),
      ),
    );

    try {
      await ref
          .read(surveyProvider.notifier)
          .participateInSurvey(survey.id!, _answers);

      if (!mounted) return;

      // Cerrar diálogo de carga
      Navigator.of(context).pop();

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: colors.onPrimaryContainer),
              SizedBox(width: 8),
              Text(
                '¡Gracias por participar!',
                style: TextStyle(color: colors.onPrimaryContainer),
              ),
            ],
          ),
          backgroundColor: colors.primaryContainer,
          duration: Duration(seconds: 2),
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Regresar a la pantalla anterior
      Navigator.of(context).pop();
    } catch (e) {
      if (!mounted) return;

      // Cerrar diálogo de carga
      Navigator.of(context).pop();

      // Mostrar error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.error_outline, color: colors.onError),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  'Error al enviar respuestas: $e',
                  style: TextStyle(color: colors.onError),
                ),
              ),
            ],
          ),
          backgroundColor: colors.error,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
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
                      if (question.esOpcionUnica) ...[
                        Builder(
                          builder: (context) {
                            final selectedOptionId = _answers
                                .firstWhere(
                                  (a) => a.preguntaId == question.id,
                                  orElse: () =>
                                      SurveyAnswer(preguntaId: question.id!),
                                )
                                .opcionId;

                            return Column(
                              children: question.opciones.map((option) {
                                return RadioListTile<int?>(
                                  value: option.id,
                                  groupValue: selectedOptionId,
                                  title: Text(option.text),
                                  onChanged: (value) {
                                    if (value != null) {
                                      _selectOption(question, value);
                                    }
                                  },
                                );
                              }).toList(),
                            );
                          },
                        ),
                      ] else ...[
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
                onPressed: () => _submitSurvey(context),
                child: const Text('Enviar Respuestas'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
