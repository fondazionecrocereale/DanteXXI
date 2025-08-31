import 'package:flutter/material.dart';

class AppColors {
  // Colores principales italianos
  static const Color primaryBlue = Color(0xFF009246); // Verde italiano
  static const Color primaryRed = Color(0xFFCE2B37); // Rojo italiano
  static const Color primaryWhite = Color(0xFFFFFFFF); // Blanco italiano

  // Colores secundarios
  static const Color secondaryBlue = Color(0xFF1E88E5);
  static const Color secondaryGreen = Color(0xFF4CAF50);
  static const Color secondaryOrange = Color(0xFFFF9800);
  static const Color secondaryPurple = Color(0xFF9C27B0);

  // Colores de estado
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFF44336);
  static const Color info = Color(0xFF2196F3);

  // Colores de texto
  static const Color textPrimary = Color(0xFF212121);
  static const Color textSecondary = Color(0xFF757575);
  static const Color textLight = Color(0xFFBDBDBD);
  static const Color textWhite = Color(0xFFFFFFFF);

  // Colores de fondo
  static const Color backgroundPrimary = Color(0xFFFAFAFA);
  static const Color backgroundSecondary = Color(0xFFF5F5F5);
  static const Color backgroundCard = Color(0xFFFFFFFF);
  static const Color backgroundDark = Color(0xFF121212);

  // Colores de borde
  static const Color borderLight = Color(0xFFE0E0E0);
  static const Color borderMedium = Color(0xFFBDBDBD);
  static const Color borderDark = Color(0xFF757575);

  // Colores de sombra
  static const Color shadowLight = Color(0x1A000000);
  static const Color shadowMedium = Color(0x33000000);
  static const Color shadowDark = Color(0x4D000000);

  // Colores de progreso
  static const Color progressBackground = Color(0xFFE0E0E0);
  static const Color progressFill = Color(0xFF4CAF50);
  static const Color progressWarning = Color(0xFFFF9800);
  static const Color progressError = Color(0xFFF44336);

  // Colores de nivel CEFR
  static const Color levelA1 = Color(0xFFE3F2FD);
  static const Color levelA2 = Color(0xFFC8E6C9);
  static const Color levelB1 = Color(0xFFFFF3E0);
  static const Color levelB2 = Color(0xFFF3E5F5);
  static const Color levelC1 = Color(0xFFE8F5E8);
  static const Color levelC2 = Color(0xFFFCE4EC);

  // Colores de modo oscuro
  static const Color darkBackground = Color(0xFF121212);
  static const Color darkSurface = Color(0xFF1E1E1E);
  static const Color darkCard = Color(0xFF2D2D2D);
  static const Color darkText = Color(0xFFE0E0E0);
  static const Color darkTextSecondary = Color(0xFFBDBDBD);

  // Gradientes
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryBlue, secondaryBlue],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient italianGradient = LinearGradient(
    colors: [primaryBlue, primaryWhite, primaryRed],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient successGradient = LinearGradient(
    colors: [success, Color(0xFF66BB6A)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}
