class AppConstants {
  // App Info
  static const String appName = 'DanteXXI';
  static const String appVersion = '1.0.0';
  static const String appDescription =
      'Aprende italiano de manera moderna y efectiva';

  // API Configuration
  static const String baseUrl = 'https://dantexxi-api.onrender.com';
  static const String apiVersion = '';
  static const Duration connectionTimeout = Duration(seconds: 30);
  static const Duration receiveTimeout = Duration(seconds: 30);

  // Local Storage Keys
  static const String userTokenKey = 'user_token';
  static const String userProfileKey = 'user_profile';
  static const String appThemeKey = 'app_theme';
  static const String languageKey = 'language';
  static const String onboardingCompletedKey = 'onboarding_completed';

  // CEFR Levels
  static const List<String> cefrLevels = ['A1', 'A2', 'B1', 'B2', 'C1', 'C2'];

  // Exercise Types
  static const List<String> exerciseTypes = [
    'multiple_choice',
    'translation',
    'fill_blank',
    'matching_pairs',
    'identification',
  ];

  // Audio Configuration
  static const List<double> audioSpeeds = [0.5, 0.75, 1.0, 1.25, 1.5, 2.0];
  static const double defaultAudioSpeed = 1.0;

  // UI Configuration
  static const Duration animationDuration = Duration(milliseconds: 300);
  static const Duration splashDuration = Duration(seconds: 3);

  // Pagination
  static const int defaultPageSize = 20;
  static const int maxPageSize = 100;

  // Cache Configuration
  static const Duration cacheDuration = Duration(days: 7);
  static const int maxCacheSize = 100 * 1024 * 1024; // 100MB

  // Error Messages
  static const String networkErrorMessage =
      'Error de conexión. Verifica tu internet.';
  static const String generalErrorMessage = 'Algo salió mal. Intenta de nuevo.';
  static const String authenticationErrorMessage =
      'Sesión expirada. Inicia sesión nuevamente.';
}
