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
        // CORREGIDO: Sintaxis incorrecta con asteriscos
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
          builder: (context, setDialogState) {
            // CORREGIDO: Renombrado para evitar conflictos
            return AlertDialog(
              title: const Text('Nueva Pregunta'),
              content: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    TextField(
                      decoration: const InputDecoration(labelText: 'Pregunta'),
                      onChanged: (value) => questionText = value,
                      // AGREGADO: Autofocus para mejor UX
                      autofocus: true,
                    ),
                    const SizedBox(height: 16),
                    DropdownButtonFormField<String>(
                      value: questionType,
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
                        if (value != null) {
                          setDialogState(() {
                            questionType = value;
                          });
                        }
                      },
                    ),
                    if (questionType == 'opcion_unica') ...[
                      const SizedBox(height: 16),
                      // CORREGIDO: Mejor manejo de la lista de opciones
                      if (options.isEmpty)
                        const Padding(
                          padding: EdgeInsets.all(16.0),
                          child: Text(
                            'No hay opciones. Agrega al menos una opción.',
                            style: TextStyle(color: Colors.grey),
                            textAlign: TextAlign.center,
                          ),
                        )
                      else
                        ...options.asMap().entries.map(
                          (entry) => Card(
                            child: ListTile(
                              title: Text(entry.value),
                              leading: CircleAvatar(
                                radius: 12,
                                child: Text('${entry.key + 1}'),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () {
                                  setDialogState(() {
                                    options.removeAt(entry.key);
                                  });
                                },
                              ),
                            ),
                          ),
                        ),
                      const SizedBox(height: 8),
                      OutlinedButton.icon(
                        onPressed: () async {
                          final result = await _showAddOptionDialog();
                          if (result != null && result.isNotEmpty) {
                            setDialogState(() {
                              options.add(result);
                            });
                          }
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
                  onPressed: isProcessing
                      ? null
                      : () {
                          Navigator.of(context).pop();
                        },
                  child: const Text('Cancelar'),
                ),
                FilledButton(
                  onPressed: isProcessing
                      ? null
                      : () async {
                          // CORREGIDO: Mejor validación
                          if (questionText.trim().isEmpty) {
                            _showErrorSnackBar(
                              'Por favor ingresa el texto de la pregunta',
                            );
                            return;
                          }

                          if (questionType == 'opcion_unica' &&
                              options.length < 2) {
                            _showErrorSnackBar(
                              'Las preguntas de opción única necesitan al menos 2 opciones',
                            );
                            return;
                          }

                          setDialogState(() => isProcessing = true);

                          try {
                            final surveyOptions = options
                                .asMap()
                                .entries
                                .map(
                                  (e) => SurveyOption(
                                    text: e.value.trim(),
                                    orden: e.key + 1,
                                  ),
                                )
                                .toList();

                            final question = SurveyQuestion(
                              text: questionText.trim(),
                              esOpcionUnica: questionType == 'opcion_unica',
                              orden: _questions.length + 1,
                              opciones: questionType == 'opcion_unica'
                                  ? surveyOptions
                                  : [],
                            );

                            // CORREGIDO: Delay innecesario removido
                            if (!mounted) return;

                            Navigator.of(context).pop();

                            setState(() {
                              _questions.add(question);
                            });
                          } catch (e) {
                            if (mounted) {
                              _showErrorSnackBar(
                                'Error al crear la pregunta: $e',
                              );
                            }
                          } finally {
                            if (mounted) {
                              setDialogState(() => isProcessing = false);
                            }
                          }
                        },
                  child: isProcessing
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              Colors.white,
                            ),
                          ),
                        )
                      : const Text('Guardar'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Future<String?> _showAddOptionDialog() async {
    final controller = TextEditingController();

    return showDialog<String>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Nueva Opción'),
          content: TextField(
            controller: controller,
            decoration: const InputDecoration(
              labelText: 'Texto de la opción',
              hintText: 'Ej: Opción A',
            ),
            autofocus: true,
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                Navigator.of(context).pop(value.trim());
              }
            },
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Cancelar'),
            ),
            FilledButton(
              onPressed: () {
                final value = controller.text.trim();
                if (value.isNotEmpty) {
                  Navigator.of(context).pop(value);
                }
              },
              child: const Text('Agregar'),
            ),
          ],
        );
      },
    );
  }

  // AGREGADO: Método para mostrar errores
  void _showErrorSnackBar(String message) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            const Icon(Icons.error_outline, color: Colors.white),
            const SizedBox(width: 8),
            Expanded(child: Text(message)),
          ],
        ),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  Future<void> _saveSurvey(BuildContext context) async {
    final colors = Theme.of(context).colorScheme;

    // CORREGIDO: Mejor validación
    if (_titleController.text.trim().isEmpty) {
      _showErrorSnackBar('Por favor ingresa un título para la encuesta');
      return;
    }

    if (_descriptionController.text.trim().isEmpty) {
      _showErrorSnackBar('Por favor ingresa una descripción para la encuesta');
      return;
    }

    if (_questions.isEmpty) {
      _showErrorSnackBar('Por favor agrega al menos una pregunta');
      return;
    }

    // CORREGIDO: Validar que las fechas sean lógicas
    if (_endDate.isBefore(_startDate)) {
      _showErrorSnackBar(
        'La fecha de fin no puede ser anterior a la fecha de inicio',
      );
      return;
    }

    // Mostrar diálogo de carga
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => const AlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CircularProgressIndicator(),
            SizedBox(height: 16),
            Text('Guardando encuesta...'),
          ],
        ),
      ),
    );

    final survey = Survey(
      titulo: _titleController.text.trim(),
      descripcion: _descriptionController.text.trim(),
      fechaInicio: _startDate,
      fechaFin: _endDate,
      isActive: true,
      preguntas: _questions,
    );

    try {
      await ref.read(surveyProvider.notifier).createSurvey(survey);

      if (!mounted) return;

      // Cerrar diálogo de carga
      Navigator.of(context).pop();

      // Mostrar éxito
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.white),
              SizedBox(width: 8),
              Text('Encuesta creada exitosamente'),
            ],
          ),
          backgroundColor: colors.primary,
          behavior: SnackBarBehavior.floating,
        ),
      );

      // Volver a la página anterior
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
              const Icon(Icons.error_outline, color: Colors.white),
              const SizedBox(width: 8),
              Expanded(child: Text('Error al crear la encuesta: $e')),
            ],
          ),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 4),
          behavior: SnackBarBehavior.floating,
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () =>
                ScaffoldMessenger.of(context).hideCurrentSnackBar(),
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
                hintText: 'Ej: Encuesta de Satisfacción',
              ),
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Descripción',
                border: OutlineInputBorder(),
                hintText: 'Describe el propósito de esta encuesta...',
              ),
              maxLines: 3,
              textCapitalization: TextCapitalization.sentences,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: const Text('Fecha de inicio'),
                      subtitle: Text(dateFormat.format(_startDate)),
                      onTap: _selectStartDate,
                      trailing: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Card(
                    child: ListTile(
                      title: const Text('Fecha de fin'),
                      subtitle: Text(dateFormat.format(_endDate)),
                      onTap: _selectEndDate,
                      trailing: const Icon(Icons.calendar_today),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),
            Row(
              children: [
                const Text(
                  'Preguntas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const Spacer(),
                Text(
                  '${_questions.length} pregunta${_questions.length != 1 ? 's' : ''}',
                  style: TextStyle(color: Colors.grey[600]),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // CORREGIDO: Mejor presentación de las preguntas
            if (_questions.isEmpty)
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(24.0),
                  child: Column(
                    children: [
                      Icon(
                        Icons.quiz_outlined,
                        size: 48,
                        color: Colors.grey[400],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'No hay preguntas aún',
                        style: TextStyle(color: Colors.grey[600], fontSize: 16),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Agrega preguntas para tu encuesta',
                        style: TextStyle(color: Colors.grey[500]),
                      ),
                    ],
                  ),
                ),
              )
            else
              ...List.generate(_questions.length, (index) {
                final question = _questions[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ExpansionTile(
                    leading: CircleAvatar(
                      radius: 16,
                      child: Text('${index + 1}'),
                    ),
                    title: Text(
                      question.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    subtitle: Text(
                      question.esOpcionUnica
                          ? '${question.opciones.length} opciones'
                          : 'Respuesta de texto',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      onPressed: () {
                        setState(() {
                          _questions.removeAt(index);
                          // CORREGIDO: Reordenar preguntas correctamente
                          for (var i = 0; i < _questions.length; i++) {
                            _questions[i] = _questions[i].copyWith(
                              orden: i + 1,
                            );
                          }
                        });
                      },
                    ),
                    children:
                        question.esOpcionUnica && question.opciones.isNotEmpty
                        ? [
                            Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Opciones:',
                                    style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  ...question.opciones.map(
                                    (option) => Padding(
                                      padding: const EdgeInsets.only(
                                        left: 16,
                                        bottom: 4,
                                      ),
                                      child: Row(
                                        children: [
                                          Text('• '),
                                          Expanded(child: Text(option.text)),
                                        ],
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ]
                        : [],
                  ),
                );
              }),

            const SizedBox(height: 16),
            OutlinedButton.icon(
              onPressed: _addQuestion,
              icon: const Icon(Icons.add),
              label: const Text('Agregar Pregunta'),
              style: OutlinedButton.styleFrom(
                padding: const EdgeInsets.all(16),
              ),
            ),
            const SizedBox(height: 32),
            FilledButton(
              onPressed: _questions.isEmpty ? null : () => _saveSurvey(context),
              style: FilledButton.styleFrom(padding: const EdgeInsets.all(16)),
              child: const Text('Guardar Encuesta'),
            ),
          ],
        ),
      ),
    );
  }
}
