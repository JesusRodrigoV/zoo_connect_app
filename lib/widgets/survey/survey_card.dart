import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:zoo_connect_app/models/survey/survey.dart';

class SurveyCard extends StatelessWidget {
  final Survey survey;
  final VoidCallback onTap;

  const SurveyCard({super.key, required this.survey, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final dateFormat = DateFormat('dd/MM/yyyy');

    return Card(
      clipBehavior: Clip.hardEdge,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      survey.titulo,
                      style: theme.textTheme.titleMedium,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: survey.isActive
                          ? theme.colorScheme.primaryContainer
                          : theme.colorScheme.errorContainer,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      survey.isActive ? 'Activa' : 'Inactiva',
                      style: TextStyle(
                        color: survey.isActive
                            ? theme.colorScheme.onPrimaryContainer
                            : theme.colorScheme.onErrorContainer,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              if (survey.descripcion.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  survey.descripcion,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
              ],
              const SizedBox(height: 16),
              Row(
                children: [
                  Icon(
                    Icons.calendar_today,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Del ${dateFormat.format(survey.fechaInicio)} al ${dateFormat.format(survey.fechaFin)}',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    Icons.help_outline,
                    size: 16,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    '${survey.preguntas.length} preguntas',
                    style: TextStyle(
                      color: theme.colorScheme.onSurfaceVariant,
                      fontSize: 12,
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
