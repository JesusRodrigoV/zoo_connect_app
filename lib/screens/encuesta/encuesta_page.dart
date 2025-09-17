import 'package:flutter/material.dart';
import 'package:flutter_survey/flutter_survey.dart';
import 'package:zoo_connect_app/models/encuesta/encuesta.dart';

class EncuestaPage extends StatefulWidget {
  final Encuesta encuesta;

  const EncuestaPage({super.key, required this.encuesta});

  @override
  State<EncuestaPage> createState() => _EncuestaPageState();
}

class _EncuestaPageState extends State<EncuestaPage> {
  final _formKey = GlobalKey<FormState>();
  List<QuestionResult> _questionResults = [];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: Icon(Icons.arrow_back),
        ),
        title: Text(widget.encuesta.titulo),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.encuesta.descripcion,
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: Form(
                key: _formKey,
                child: Survey(
                  initialData: widget.encuesta.preguntas,
                  onNext: (questionResults) {
                    setState(() {
                      _questionResults = questionResults;
                    });
                  },
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: FilledButton(onPressed: () {}, child: Text("Enviar")),
            ),
          ],
        ),
      ),
    );
  }
}
