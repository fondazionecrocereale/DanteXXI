import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../domain/entities/editable_profile.dart';
import 'storage_service.dart';

class ProfileService {
  static const String _profileKey = 'user_profile';
  static const String _profileImageKey = 'profile_image';
  static const String _sessionKey = 'user_session';

  // Guardar perfil completo
  static Future<void> saveProfile(EditableProfile profile) async {
    try {
      print('🔐 ProfileService.saveProfile() - Iniciando...');

      final prefs = await SharedPreferences.getInstance();
      final profileJson = profile.toJson();

      // Guardar perfil
      await prefs.setString(_profileKey, json.encode(profileJson));
      print('✅ ProfileService.saveProfile() - Perfil guardado en $_profileKey');

      // Marcar sesión activa
      await prefs.setString(_sessionKey, 'active');
      print(
        '✅ ProfileService.saveProfile() - Sesión marcada como activa en $_sessionKey',
      );

      // Sincronizar con StorageService
      await StorageService.setLoggedIn(true);
      print(
        '✅ ProfileService.saveProfile() - StorageService.setLoggedIn(true) completado',
      );

      // Verificar que se guardó correctamente
      final savedProfile = await getProfile();
      final hasSession = await hasActiveSession();
      print(
        '🔍 ProfileService.saveProfile() - Verificación: profile=${savedProfile != null}, session=$hasSession',
      );
    } catch (e) {
      print('❌ ProfileService.saveProfile() - Error: $e');
      rethrow;
    }
  }

  // Obtener perfil guardado
  static Future<EditableProfile?> getProfile() async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Verificar sesión activa
      final sessionString = prefs.getString(_sessionKey);
      print(
        '🔍 ProfileService.getProfile() - Session key $_sessionKey: $sessionString',
      );

      if (sessionString == null) {
        print('❌ ProfileService.getProfile() - No hay sesión activa');
        return null;
      }

      // Obtener perfil
      final profileString = prefs.getString(_profileKey);
      print(
        '🔍 ProfileService.getProfile() - Profile key $_profileKey: ${profileString != null ? 'existe' : 'no existe'}',
      );

      if (profileString != null) {
        try {
          final profileJson = json.decode(profileString);
          final profile = EditableProfile.fromJson(profileJson);
          print(
            '✅ ProfileService.getProfile() - Perfil recuperado: ${profile.firstName} ${profile.lastName}',
          );
          return profile;
        } catch (e) {
          print('❌ ProfileService.getProfile() - Error al parsear perfil: $e');
          await clearProfile();
          return null;
        }
      }

      print('❌ ProfileService.getProfile() - No hay perfil guardado');
      return null;
    } catch (e) {
      print('❌ ProfileService.getProfile() - Error general: $e');
      return null;
    }
  }

  // Verificar si hay una sesión activa
  static Future<bool> hasActiveSession() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final sessionString = prefs.getString(_sessionKey);
      final hasSession = sessionString != null;
      print(
        '🔍 ProfileService.hasActiveSession() - Session key $_sessionKey: $sessionString (hasSession: $hasSession)',
      );
      return hasSession;
    } catch (e) {
      print('❌ ProfileService.hasActiveSession() - Error: $e');
      return false;
    }
  }

  // Actualizar perfil parcialmente
  static Future<void> updateProfile(ProfileUpdateRequest updates) async {
    final currentProfile = await getProfile();
    if (currentProfile != null) {
      final updatedProfile = currentProfile.copyWith(
        firstName: updates.firstName ?? currentProfile.firstName,
        lastName: updates.lastName ?? currentProfile.lastName,
        avatar: updates.avatar ?? currentProfile.avatar,
        level: updates.level ?? currentProfile.level,
        country: updates.country ?? currentProfile.country,
        language: updates.language ?? currentProfile.language,
        interests: updates.interests ?? currentProfile.interests,
        bio: updates.bio ?? currentProfile.bio,
        birthDate: updates.birthDate ?? currentProfile.birthDate,
        phoneNumber: updates.phoneNumber ?? currentProfile.phoneNumber,
        timezone: updates.timezone ?? currentProfile.timezone,
        emailNotifications:
            updates.emailNotifications ?? currentProfile.emailNotifications,
        pushNotifications:
            updates.pushNotifications ?? currentProfile.pushNotifications,
        learningGoal: updates.learningGoal ?? currentProfile.learningGoal,
        dailyGoalMinutes:
            updates.dailyGoalMinutes ?? currentProfile.dailyGoalMinutes,
      );
      await saveProfile(updatedProfile);
    }
  }

  // Guardar imagen de perfil
  static Future<void> saveProfileImage(String imagePath) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_profileImageKey, imagePath);
  }

  // Obtener imagen de perfil
  static Future<String?> getProfileImage() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_profileImageKey);
  }

  // Limpiar perfil y sesión
  static Future<void> clearProfile() async {
    try {
      print('🗑️ ProfileService.clearProfile() - Iniciando limpieza...');

      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(_profileKey);
      await prefs.remove(_profileImageKey);
      await prefs.remove(_sessionKey);

      print('✅ ProfileService.clearProfile() - Datos locales limpiados');

      // Sincronizar con StorageService
      await StorageService.setLoggedIn(false);
      print(
        '✅ ProfileService.clearProfile() - StorageService.setLoggedIn(false) completado',
      );
    } catch (e) {
      print('❌ ProfileService.clearProfile() - Error: $e');
      rethrow;
    }
  }

  // Crear perfil por defecto
  static EditableProfile createDefaultProfile({
    required String id,
    required String email,
    required String firstName,
    required String lastName,
  }) {
    return EditableProfile(
      id: id,
      email: email,
      firstName: firstName,
      lastName: lastName,
      level: 'Principiante',
      country: 'Italia',
      language: 'Español',
      interests: ['Cultura', 'Viajes', 'Cocina'],
      bio: '¡Hola! Estoy aprendiendo italiano con DanteXXI',
      emailNotifications: true,
      pushNotifications: true,
      learningGoal: 'Ser capaz de mantener una conversación básica',
      dailyGoalMinutes: 30,
    );
  }

  // Método de debug para verificar el estado actual
  static Future<void> debugCurrentState() async {
    try {
      print('🔍 === DEBUG PROFILE SERVICE STATE ===');

      final prefs = await SharedPreferences.getInstance();

      final sessionString = prefs.getString(_sessionKey);
      final profileString = prefs.getString(_profileKey);
      final isLoggedIn = await StorageService.isLoggedIn();

      print('Session Key ($_sessionKey): $sessionString');
      print(
        'Profile Key ($_profileKey): ${profileString != null ? 'existe' : 'no existe'}',
      );
      print('StorageService.isLoggedIn(): $isLoggedIn');

      if (profileString != null) {
        try {
          final profileJson = json.decode(profileString);
          print('Profile Data: $profileJson');
        } catch (e) {
          print('Error parsing profile: $e');
        }
      }

      print('=====================================');
    } catch (e) {
      print('Error in debugCurrentState: $e');
    }
  }
}
