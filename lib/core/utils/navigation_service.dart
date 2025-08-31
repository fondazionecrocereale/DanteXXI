import 'package:flutter/material.dart';

class NavigationService {
  static final GlobalKey<NavigatorState> navigatorKey =
      GlobalKey<NavigatorState>();

  static NavigatorState? get navigator => navigatorKey.currentState;

  // Navegación básica
  static Future<T?> pushNamed<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return navigator!.pushNamed<T>(routeName, arguments: arguments);
  }

  static Future<T?> pushReplacementNamed<T extends Object?, TO extends Object?>(
    String routeName, {
    Object? arguments,
    TO? result,
  }) {
    return navigator!.pushReplacementNamed<T, TO>(
      routeName,
      arguments: arguments,
      result: result,
    );
  }

  static Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
    String routeName, {
    Object? arguments,
    bool Function(Route<dynamic>)? predicate,
  }) {
    return navigator!.pushNamedAndRemoveUntil<T>(
      routeName,
      predicate ?? (route) => false,
      arguments: arguments,
    );
  }

  static void pop<T extends Object?>([T? result]) {
    return navigator!.pop<T>(result);
  }

  static bool canPop() {
    return navigator!.canPop();
  }

  // Navegación específica de la aplicación
  static Future<dynamic> navigateToHome() {
    return pushReplacementNamed('/home');
  }

  static Future<dynamic> navigateToLogin() {
    return pushReplacementNamed('/login');
  }

  static Future<dynamic> navigateToRegister() {
    return pushNamed('/register');
  }

  static Future<dynamic> navigateToOnboarding() {
    return pushReplacementNamed('/onboarding');
  }

  static Future<T?> navigateToLessons<T extends Object?>() {
    return pushNamed<T>('/lessons');
  }

  static Future<T?> navigateToExercises<T extends Object?>() {
    return pushNamed<T>('/exercises');
  }

  static Future<T?> navigateToDictionary<T extends Object?>() {
    return pushNamed<T>('/dictionary');
  }

  static Future<T?> navigateToProfile<T extends Object?>() {
    return pushNamed<T>('/profile');
  }

  static Future<T?> navigateToSettings<T extends Object?>() {
    return pushNamed<T>('/settings');
  }

  // Navegación con parámetros
  static Future<T?> navigateToLesson<T extends Object?>(String lessonId) {
    return pushNamed<T>('/lesson/$lessonId');
  }

  static Future<T?> navigateToExercise<T extends Object?>(String exerciseId) {
    return pushNamed<T>('/exercise/$exerciseId');
  }

  static Future<T?> navigateToWord<T extends Object?>(String wordId) {
    return pushNamed<T>('/word/$wordId');
  }

  // Navegación con resultado
  static Future<T?> navigateForResult<T extends Object?>(
    String routeName, {
    Object? arguments,
  }) {
    return pushNamed<T>(routeName, arguments: arguments);
  }

  // Limpiar stack de navegación
  static void clearStackAndNavigate(String routeName) {
    pushNamedAndRemoveUntil(routeName, predicate: (route) => false);
  }

  // Navegación con transición personalizada
  static Future<T?> pushWithCustomTransition<T extends Object?>(
    Widget page, {
    String? routeName,
    Object? arguments,
  }) {
    return navigator!.push<T>(
      PageRouteBuilder<T>(
        pageBuilder: (context, animation, secondaryAnimation) => page,
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          const begin = Offset(1.0, 0.0);
          const end = Offset.zero;
          const curve = Curves.easeInOut;

          var tween = Tween(
            begin: begin,
            end: end,
          ).chain(CurveTween(curve: curve));

          return SlideTransition(
            position: animation.drive(tween),
            child: child,
          );
        },
        transitionDuration: const Duration(milliseconds: 300),
      ),
    );
  }
}
