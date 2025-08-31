import 'package:shared_preferences/shared_preferences.dart';
import 'profile_service.dart';
import 'auth_service.dart';

/// Servicio que maneja la gestión de sesión del usuario
/// Verifica automáticamente si hay una sesión activa al iniciar la aplicación
class SessionManager {
  static const String _lastLoginKey = 'last_login';

  /// Verificar si hay una sesión activa al iniciar la aplicación
  static Future<bool> checkActiveSession() async {
    try {
      print('🔍 SessionManager.checkActiveSession() - Verificando...');
      final profile = await ProfileService.getProfile();
      final hasSession = profile != null;

      if (hasSession) {
        // Hay una sesión activa, actualizar timestamp de último acceso
        await _updateLastAccess();
        print(
          '✅ SessionManager.checkActiveSession() - Sesión activa encontrada',
        );
      } else {
        print('❌ SessionManager.checkActiveSession() - No hay sesión activa');
      }

      return hasSession;
    } catch (e) {
      print('❌ SessionManager.checkActiveSession() - Error: $e');
      return false;
    }
  }

  /// Obtener información de la sesión activa
  static Future<Map<String, dynamic>?> getSessionInfo() async {
    try {
      final profile = await ProfileService.getProfile();
      if (profile != null) {
        final prefs = await SharedPreferences.getInstance();
        return {
          'isActive': true,
          'lastAccess': prefs.getString(_lastLoginKey),
          'profile': profile,
        };
      }
      return null;
    } catch (e) {
      print('❌ SessionManager.getSessionInfo() - Error: $e');
      return null;
    }
  }

  /// Iniciar sesión y guardar información de sesión
  static Future<void> startSession({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
    String? level,
    String? country,
    String? language,
    List<String>? interests,
    String? bio,
    bool? emailNotifications,
    bool? pushNotifications,
    String? learningGoal,
    int? dailyGoalMinutes,
  }) async {
    try {
      print(
        '🚀 SessionManager.startSession() - Iniciando sesión para $firstName $lastName',
      );

      // Inicializar datos del usuario usando AuthService
      await AuthService.initializeUserAfterAuth(
        id: id,
        email: email,
        firstName: firstName,
        lastName: lastName,
        level: level,
        country: country,
        language: language,
        interests: interests,
        bio: bio,
        emailNotifications: emailNotifications,
        pushNotifications: pushNotifications,
        learningGoal: learningGoal,
        dailyGoalMinutes: dailyGoalMinutes,
      );

      // Actualizar timestamp de último acceso
      await _updateLastAccess();

      print('✅ SessionManager.startSession() - Sesión iniciada exitosamente');

      // Debug: verificar estado actual
      await ProfileService.debugCurrentState();
    } catch (e) {
      print('❌ SessionManager.startSession() - Error: $e');
      rethrow;
    }
  }

  /// Cerrar sesión y limpiar datos
  static Future<void> endSession() async {
    try {
      print('🚪 SessionManager.endSession() - Cerrando sesión...');

      // Limpiar perfil usando ProfileService
      await ProfileService.clearProfile();

      // Limpiar timestamp de último acceso
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_lastLoginKey);

      print('✅ SessionManager.endSession() - Sesión cerrada exitosamente');
    } catch (e) {
      print('❌ SessionManager.endSession() - Error: $e');
      rethrow;
    }
  }

  /// Verificar si la sesión ha expirado (opcional)
  static Future<bool> isSessionExpired({
    Duration maxAge = const Duration(days: 30),
  }) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final lastLoginString = prefs.getString(_lastLoginKey);

      if (lastLoginString != null) {
        final lastLogin = DateTime.parse(lastLoginString);
        final now = DateTime.now();
        final difference = now.difference(lastLogin);

        return difference > maxAge;
      }
      return true; // No hay sesión, considerar como expirada
    } catch (e) {
      return true;
    }
  }

  /// Actualizar timestamp de último acceso
  static Future<void> _updateLastAccess() async {
    final prefs = await SharedPreferences.getInstance();
    final now = DateTime.now().toIso8601String();
    await prefs.setString(_lastLoginKey, now);
  }

  /// Ejemplo de uso: Iniciar sesión con usuario de prueba
  static Future<void> startTestSession() async {
    print(
      '🧪 SessionManager.startTestSession() - Iniciando sesión de prueba...',
    );

    await startSession(
      id: 'e6f1abfb-4d20-4def-a416-96326d0542a5',
      email: 'test6@gmail.com',
      firstName: 'Test6',
      lastName: 'Test6',
      level: 'A1',
      country: null,
      language: 'italiano',
      interests: <String>[],
      bio: null,
      emailNotifications: true,
      pushNotifications: true,
      learningGoal: null,
      dailyGoalMinutes: 30,
    );
  }
}
