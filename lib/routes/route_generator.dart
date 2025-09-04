import 'package:flutter/material.dart';
import '../presentation/pages/home_page.dart';
import '../presentation/pages/lessons_page.dart';
import '../presentation/pages/exercises_page.dart';
import '../presentation/pages/dictionary_page.dart';
import '../presentation/pages/profile_page.dart';
import '../presentation/pages/settings_page.dart';
import '../presentation/pages/reels_page.dart';
import '../presentation/pages/auth/login_page.dart';
import '../presentation/pages/onboarding_page.dart';

class RouteGenerator {
  static const String home = '/';
  static const String lessons = '/lessons';
  static const String exercises = '/exercises';
  static const String dictionary = '/dictionary';
  static const String profile = '/profile';
  static const String settings = '/settings';
  static const String reels = '/reels';
  static const String videoPlayer = '/video-player';
  static const String login = '/login';
  static const String onboarding = '/onboarding';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    if (settings.name == home) {
      return MaterialPageRoute(builder: (_) => const HomePage());
    } else if (settings.name == lessons) {
      return MaterialPageRoute(builder: (_) => const LessonsPage());
    } else if (settings.name == exercises) {
      return MaterialPageRoute(builder: (_) => const ExercisesPage());
    } else if (settings.name == dictionary) {
      return MaterialPageRoute(builder: (_) => const DictionaryPage());
    } else if (settings.name == profile) {
      return MaterialPageRoute(builder: (_) => const ProfilePage());
    } else if (settings.name == settings) {
      return MaterialPageRoute(builder: (_) => const SettingsPage());
    } else if (settings.name == reels) {
      return MaterialPageRoute(builder: (_) => const ReelsPage());
    } else if (settings.name == videoPlayer) {
      // Esta ruta requiere parámetros, se maneja desde la página
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(child: Text('Ruta de video no válida')),
        ),
      );
    } else if (settings.name == login) {
      return MaterialPageRoute(builder: (_) => const LoginPage());
    } else if (settings.name == onboarding) {
      return MaterialPageRoute(builder: (_) => const OnboardingPage());
    } else {
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(child: Text('Ruta no encontrada: ${settings.name}')),
        ),
      );
    }
  }
}
