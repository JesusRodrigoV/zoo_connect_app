import 'package:flutter/material.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';

class EncuestaCard extends StatefulWidget {
  final Survey encuesta;

  const EncuestaCard({super.key, required this.encuesta});

  @override
  State<EncuestaCard> createState() => _EncuestaCardState();
}

class _EncuestaCardState extends State<EncuestaCard> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text(widget.encuesta.titulo),
            content: SingleChildScrollView(
              child: Text(
                widget.encuesta.descripcion,
                style: TextStyle(fontSize: 16),
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Cerrar'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ),
      child: SizedBox(
        width: 300,
        child: Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25),
          ),
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.encuesta.titulo,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 15),
                Expanded(
                  child: Text(
                    widget.encuesta.descripcion,
                    style: TextStyle(fontSize: 16),
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.left,
                  ),
                ),
                SizedBox(height: 15),
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: () => Navigator.pushNamed(
                      context,
                      '/surveys/participate',
                      arguments: widget.encuesta.id,
                    ),
                    child: Text(
                      "Participar",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
