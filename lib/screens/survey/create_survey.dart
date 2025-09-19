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
    showDialog(
      context: context,
      builder: (context) {
        String questionText = '';
        String questionType = 'opcion_unica';
        final options = <String>[];

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
                          showDialog(
                            context: context,
                            builder: (context) {
                              String optionText = '';
                              return AlertDialog(
                                title: const Text('Nueva Opción'),
                                content: TextField(
                                  decoration: const InputDecoration(
                                    labelText: 'Texto de la opción',
                                  ),
                                  onChanged: (value) => optionText = value,
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
                                      if (optionText.trim().isNotEmpty) {
                                        setState(() {
                                          options.add(optionText);
                                        });
                                        Navigator.of(context).pop();
                                      }
                                    },
                                    child: const Text('Agregar'),
                                  ),
                                ],
                              );
                            },
                          );
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
                  onPressed: () {
                    if (questionText.trim().isEmpty ||
                        (questionType == 'opcion_unica' && options.isEmpty)) {
                      return;
                    }

                    final surveyOptions = options
                        .asMap()
                        .entries
                        .map(
                          (e) => SurveyOption(text: e.value, orden: e.key + 1),
                        )
                        .toList();

                    final question = SurveyQuestion(
                      text: questionText,
                      type: questionType,
                      orden: _questions.length + 1,
                      opciones: surveyOptions,
                    );

                    setState(() {
                      _questions.add(question);
                    });

                    Navigator.of(context).pop();
                  },
                  child: const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<void> _saveSurvey() async {
    if (_titleController.text.trim().isEmpty ||
        _descriptionController.text.trim().isEmpty ||
        _questions.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor complete todos los campos')),
      );
      return;
    }

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
                    question.type == 'opcion_unica'
                        ? '${question.opciones.length} opciones'
                        : 'Respuesta de texto',
                  ),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      setState(() {
                        _questions.remove(question);
                        // Actualizar el orden de las preguntas restantes
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
              onPressed: _questions.isEmpty ? null : _saveSurvey,
              child: const Text('Guardar Encuesta'),
            ),
          ],
        ),
      ),
    );
  }
}
