import 'package:flutter/material.dart';
import 'package:zoo_connect_app/screens/auth/login.dart';
import 'package:zoo_connect_app/screens/auth/signup.dart';
import 'package:zoo_connect_app/screens/auth/bienvenida.dart';
import 'package:zoo_connect_app/screens/home.dart';
import 'package:zoo_connect_app/screens/survey/create_survey.dart';
import 'package:zoo_connect_app/screens/survey/survey_list.dart';
import 'package:zoo_connect_app/screens/survey/survey_participation.dart';
import 'package:zoo_connect_app/screens/admin/admin_panel.dart';
import 'package:zoo_connect_app/screens/survey/survey_stats.dart';
import 'package:zoo_connect_app/widgets/auth/protected_route.dart';

class AppRouter {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
          builder: (_) => const ProtectedRoute(
            requiresAuth: false,
            child: BienvenidaScreen(),
          ),
        );

      case '/bienvenida':
        return MaterialPageRoute(
          builder: (_) => const ProtectedRoute(
            requiresAuth: false,
            child: BienvenidaScreen(),
          ),
        );

      case '/login':
        return MaterialPageRoute(
          builder: (_) =>
              const ProtectedRoute(requiresAuth: false, child: LoginScreen()),
        );

      case '/signup':
        return MaterialPageRoute(
          builder: (_) =>
              const ProtectedRoute(requiresAuth: false, child: SignupScreen()),
        );

      case '/home':
        return MaterialPageRoute(builder: (_) => const Home());
      case '/admin':
        return MaterialPageRoute(
          builder: (_) => const ProtectedRoute(
            requiresAuth: true,
            requiresAdmin: true,
            child: AdminPanelPage(),
          ),
        );

      case '/surveys':
        return MaterialPageRoute(
          builder: (_) => const ProtectedRoute(
            requiresAuth: true,
            requiresAdmin: true,
            child: SurveyListPage(),
          ),
        );

      case '/surveys/create':
        return MaterialPageRoute(
          builder: (_) => const ProtectedRoute(
            requiresAuth: true,
            requiresAdmin: true,
            child: CreateSurveyPage(),
          ),
        );

      case '/surveys/participate':
        final surveyId = settings.arguments as int;
        return MaterialPageRoute(
          builder: (_) => ProtectedRoute(
            requiresAuth: true,
            requiresAdmin: false,
            child: SurveyParticipationPage(surveyId: surveyId),
          ),
        );

      case '/surveys/stats':
        return MaterialPageRoute(
          builder: (_) => const ProtectedRoute(
            requiresAuth: true,
            requiresAdmin: true,
            child: SurveyStatsPage(),
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
