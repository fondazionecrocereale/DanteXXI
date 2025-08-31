import 'profile_service.dart';
import '../../domain/entities/editable_profile.dart';

/// Servicio para inicializar los datos del usuario con información real
/// Este servicio debe ser llamado después de la autenticación exitosa
class UserInitializationService {
  /// Inicializa los datos del usuario con información real desde la base de datos
  /// o desde la respuesta de autenticación
  static Future<void> initializeUserFromAuth({
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
    // Crear el perfil del usuario con los datos reales
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

    // Guardar el perfil usando ProfileService.saveProfile()
    await ProfileService.saveProfile(userProfile);
  }

  /// Ejemplo de uso: Inicializar usuario con datos de ejemplo
  /// En una aplicación real, estos datos vendrían de la base de datos
  static Future<void> initializeExampleUser() async {
    // Crear el perfil del usuario con datos de ejemplo
    final userProfile = EditableProfile(
      id: 'user_123',
      email: 'dante@example.com',
      firstName: 'Dante',
      lastName: 'Alighieri',
      level: 'Intermedio',
      country: 'Italia',
      language: 'Español',
      interests: ['Literatura', 'Historia', 'Filosofía', 'Arte'],
      bio:
          'Amo la literatura italiana y quiero mejorar mi comprensión del idioma',
      emailNotifications: true,
      pushNotifications: true,
      learningGoal: 'Leer la Divina Comedia en italiano original',
      dailyGoalMinutes: 45,
    );

    // Guardar el perfil usando ProfileService.saveProfile()
    await ProfileService.saveProfile(userProfile);
  }

  /// Ejemplo de uso: Inicializar usuario con datos mínimos
  static Future<void> initializeMinimalUser({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
  }) async {
    // Crear el perfil del usuario con datos mínimos
    final userProfile = EditableProfile(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      // Los demás campos se establecerán con valores por defecto
    );

    // Guardar el perfil usando ProfileService.saveProfile()
    await ProfileService.saveProfile(userProfile);
  }
}
