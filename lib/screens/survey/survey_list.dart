import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:zoo_connect_app/providers/auth/auth_provider.dart';
import 'package:zoo_connect_app/providers/survey/survey_provider.dart';
import 'package:zoo_connect_app/widgets/shared/custom_loader.dart';
import 'package:zoo_connect_app/widgets/survey/survey_card.dart';

class SurveyListPage extends ConsumerStatefulWidget {
  const SurveyListPage({super.key});

  @override
  ConsumerState<SurveyListPage> createState() => _SurveyListPageState();
}

class _SurveyListPageState extends ConsumerState<SurveyListPage> {
  @override
  void initState() {
    super.initState();
    Future.microtask(() => ref.read(surveyProvider.notifier).loadSurveys());
  }

  @override
  Widget build(BuildContext context) {
    final surveyState = ref.watch(surveyProvider);
    final isAdmin = ref.watch(getEsAdminProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Encuestas'), centerTitle: true),
      body: surveyState.isLoading
          ? const Center(child: CustomLoader())
          : surveyState.error != null
          ? Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Error: ${surveyState.error}',
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 16),
                  FilledButton(
                    onPressed: () {
                      ref.read(surveyProvider.notifier).loadSurveys();
                    },
                    child: const Text('Reintentar'),
                  ),
                ],
              ),
            )
          : surveyState.surveys.isEmpty
          ? const Center(child: Text('No hay encuestas disponibles'))
          : RefreshIndicator(
              onRefresh: () async {
                await ref.read(surveyProvider.notifier).loadSurveys();
              },
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: surveyState.surveys.length,
                itemBuilder: (context, index) {
                  final survey = surveyState.surveys[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: SurveyCard(
                      survey: survey,
                      onTap: () {
                        Navigator.pushNamed(
                          context,
                          '/surveys/participate',
                          arguments: survey.id,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
      floatingActionButton: isAdmin
          ? FloatingActionButton.extended(
              onPressed: () {
                Navigator.pushNamed(context, '/surveys/create');
              },
              icon: const Icon(Icons.add),
              label: const Text('Nueva Encuesta'),
            )
          : null,
    );
  }
}
