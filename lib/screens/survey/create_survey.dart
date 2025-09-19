import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';
import 'package:zoo_connect_app/models/survey/survey_option.dart';
import 'package:zoo_connect_app/models/survey/survey_question.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';

class CreateSurveyPage extends ConsumerStatefulWidget {
  const CreateSurveyPage({super.key});

  @override
  ConsumerState<CreateSurveyPage> createState() => _CreateSurveyPageState();
}

class _CreateSurveyPageState extends ConsumerState<CreateSurveyPage> {
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _questions = <SurveyQuestion>[];
  DateTime _startDate = DateTime.now();
  DateTime _endDate = DateTime.now().add(const Duration(days: 7));

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectStartDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _startDate,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _startDate = picked;
        if (_endDate.isBefore(_startDate)) {
          _endDate = _startDate.add(const Duration(days: 1));
        }
      });
    }
  }

  Future<void> _selectEndDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _endDate,
      firstDate: _startDate,
      lastDate: DateTime.now().add(const Duration(days: 365)),
    );
    if (picked != null) {
      setState(() {
        _endDate = picked;
      });
    }
  }

  void _addQuestion() {
    String questionText = '';
    String questionType = 'opcion_unica';
    final options = <String>[];
    bool isProcessing = false;

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return AlertDialog(
              title: const Text('Nueva Pregunta'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Pregunta'),
                      onChanged: (value) => questionText = value,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      initialValue: questionType,
                      decoration: const InputDecoration(
                        labelText: 'Tipo de Pregunta',
                      ),
                      items: const [
                        DropdownMenuItem(
                          value: 'opcion_unica',
                          child: Text('Opción Única'),
                        ),
                        DropdownMenuItem(value: 'texto', child: Text('Texto')),
                      ],
                      onChanged: (value) {
                        setState(() {
                          questionType = value!;
                        });
                      },
                    ),
                    if (questionType == 'opcion_unica') ...[
                      const SizedBox(height: 16),
                      ...options.asMap().entries.map(
                        (entry) => Row(
                          children: [
                            Expanded(child: Text(entry.value)),
                            IconButton(
                              icon: const Icon(Icons.delete),
                              onPressed: () {
                                setState(() {
                                  options.removeAt(entry.key);
                                });
                              },
                            ),
                          ],
                        ),
                      ),
                      TextButton.icon(
                        onPressed: () {
                          final TextEditingController optionController =
                              TextEditingController();
                          showDialog(
                            context: context,
                            builder: (context) {
                              return AlertDialog(
                                title: const Text('Nueva Opción'),
                                content: TextField(
                                  controller: optionController,
                                  decoration: const InputDecoration(
                                    labelText: 'Texto de la opción',
                                  ),
                                  autofocus: true,
                                  onSubmitted: (value) {
                                    if (value.trim().isNotEmpty) {
                                      setState(() {
                                        options.add(value);
                                      });
                                      Navigator.of(context).pop();
                                    }
                                  },
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    child: const Text('Cancelar'),
                                  ),
                                  FilledButton(
                                    onPressed: () {
                                      final value = optionController.text;
                                      if (value.trim().isNotEmpty) {
                                        setState(() {
                                          options.add(value);
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Agregar'),
                                  ),
                                ],
                              );
                            },
                          ).then((_) => optionController.dispose());
                        },
                        icon: const Icon(Icons.add),
                        label: const Text('Agregar Opción'),
                      ),
                    ],
                  ],
                ),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: () async {
                    if (questionText.trim().isEmpty ||
                        (questionType == 'opcion_unica' && options.isEmpty)) {
                      return;
                    }

                    setState(() => isProcessing = true);

                    try {
                      final surveyOptions = options
                          .asMap()
                          .entries
                          .map(
                            (e) =>
                                SurveyOption(text: e.value, orden: e.key + 1),
                          )
                          .toList();

                      final question = SurveyQuestion(
                        text: questionText,
                        esOpcionUnica: questionType == 'opcion_unica',
                        orden: _questions.length + 1,
                        opciones: surveyOptions,
                      );

                      await Future.delayed(const Duration(milliseconds: 100));

                      if (!context.mounted) return;

                      Navigator.of(context).pop();

                      setState(() {
                        _questions.add(question);
                      });
                    } finally {
                      if (context.mounted) {
                        setState(() => isProcessing = false);
                      }
                    }
                  },
                  child: Builder(
                    builder: (context) {
                      if (isProcessing) {
                        return const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        );
                      }
                      return const Text('Guardar');
                    },
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveSurvey(BuildContext context) async {
    final colors = Theme.of(context).colorScheme;

    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Por favor complete todos los campos'),
          backgroundColor: Colors.orange,
        ),
      );
      return;
    }

    // Mostrar diálogo de carga
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
                Text('Guardando encuesta...'),
              ],
            ),
          ),
        ),
      ),
    );

    final survey = Survey(
      titulo: _titleController.text,
      descripcion: _descriptionController.text,
      fechaInicio: _startDate,
      fechaFin: _endDate,
      isActive: true,
      preguntas: _questions,
    );

    try {
      await ref.read(surveyProvider.notifier).createSurvey(survey);

      if (!mounted) return;

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Mostrar mensaje de éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text(
                'Encuesta creada exitosamente',
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

      // Cerrar el diálogo de carga
      Navigator.of(context).pop();

      // Mostrar mensaje de error
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Row(
            children: [
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text('Error al crear la encuesta: $e')),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
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
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Scaffold(
      appBar: AppBar(title: const Text('Nueva Encuesta'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Título',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ListTile(
                    title: const Text('Fecha de inicio'),
                    subtitle: Text(dateFormat.format(_startDate)),
                    onTap: _selectStartDate,
                    trailing: const Icon(Icons.calendar_today),
                  ),
                ),
                Expanded(
                  child: ListTile(
                    title: const Text('Fecha de fin'),
                    subtitle: Text(dateFormat.format(_endDate)),
                    onTap: _selectEndDate,
                    trailing: const Icon(Icons.calendar_today),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            const Text(
              'Preguntas',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            ..._questions.map((question) {
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(question.text),
                  subtitle: Text(
                    question.esOpcionUnica
                        ? '${question.opciones.length} opciones'
                        : 'Respuesta de texto',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _questions.remove(question);
                        for (var i = 0; i < _questions.length; i++) {
                          _questions[i] = _questions[i].copyWith(orden: i + 1);
                        }
                      });
                    },
                  ),
                ),
              );
            }),
            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _addQuestion,
              icon: const Icon(Icons.add),
              label: const Text('Agregar Pregunta'),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _questions.isEmpty ? null : () => _saveSurvey(context),
              child: const Text('Guardar Encuesta'),
            ),
          ],
        ),
      ),
    );
  }
}
