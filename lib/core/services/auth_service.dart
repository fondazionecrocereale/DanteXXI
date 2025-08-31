import 'profile_service.dart';
import '../../domain/entities/editable_profile.dart';

/// Servicio de autenticación que maneja la inicialización de datos del usuario
/// Este servicio debe ser llamado después de una autenticación exitosa
class AuthService {
  /// Inicializa los datos del usuario después de una autenticación exitosa
  /// Los datos deben venir de la respuesta de la API de autenticación
  static Future<void> initializeUserAfterAuth({
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
    // Crear el perfil del usuario con los datos reales de la autenticación
    final userProfile = EditableProfile(
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

    // Guardar el perfil en el almacenamiento local
    await ProfileService.saveProfile(userProfile);
  }

  /// Ejemplo de uso: Inicializar usuario con datos de la API de autenticación
  /// En una aplicación real, estos datos vendrían de la respuesta de login
  static Future<void> loginExample({
    required String email,
    required String password,
  }) async {
    // Simular llamada a API de autenticación
    // En la vida real, estos datos vendrían de tu backend

    // Datos reales del usuario de prueba de la base de datos
    final authResponse = <String, dynamic>{
      'id': 'e6f1abfb-4d20-4def-a416-96326d0542a5',
      'email': 'test6@gmail.com',
      'firstName': 'Test6',
      'lastName': 'Test6',
      'level': 'A1',
      'country': null, // null en la base de datos
      'language': 'italiano',
      'interests': <String>[], // array vacío en la base de datos
      'bio': null, // no hay bio en la base de datos
      'emailNotifications': true,
      'pushNotifications': true,
      'learningGoal': null, // no hay meta de aprendizaje en la base de datos
      'dailyGoalMinutes':
          30, // valor por defecto ya que no existe en la base de datos
    };

    // Inicializar el perfil del usuario con los datos de la API
    await initializeUserAfterAuth(
      id: authResponse['id'] as String,
      email: authResponse['email'] as String,
      firstName: authResponse['firstName'] as String,
      lastName: authResponse['lastName'] as String,
      level: authResponse['level'] as String?,
      country: authResponse['country'] as String?,
      language: authResponse['language'] as String?,
      interests: authResponse['interests'] as List<String>?,
      bio: authResponse['bio'] as String?,
      emailNotifications: authResponse['emailNotifications'] as bool?,
      pushNotifications: authResponse['pushNotifications'] as bool?,
      learningGoal: authResponse['learningGoal'] as String?,
      dailyGoalMinutes: authResponse['dailyGoalMinutes'] as int?,
    );
  }

  /// Cerrar sesión y limpiar datos del usuario
  static Future<void> logout() async {
    await ProfileService.clearProfile();
  }

  /// Verificar si el usuario está autenticado
  static Future<bool> isAuthenticated() async {
    final profile = await ProfileService.getProfile();
    return profile != null;
  }
}
