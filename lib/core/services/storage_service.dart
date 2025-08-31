import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';
import 'dart:typed_data';

class StorageService {
  static const String _tokenKey = 'auth_token';
  static const String _refreshTokenKey = 'refresh_token';
  static const String _userKey = 'user_data';
  static const String _isLoggedInKey = 'is_logged_in';
  static const String _onboardingCompletedKey = 'onboarding_completed';

  // Inicializar Hive
  static Future<void> init() async {
    await Hive.initFlutter();
    await Hive.openBox('dantexxi_storage');
  }

  // Tokens JWT
  static Future<void> saveTokens({
    required String accessToken,
    required String refreshToken,
  }) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_tokenKey, accessToken);
    await prefs.setString(_refreshTokenKey, refreshToken);
    await prefs.setBool(_isLoggedInKey, true);
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_tokenKey);
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_refreshTokenKey);
  }

  static Future<void> clearTokens() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_refreshTokenKey);
    await prefs.setBool(_isLoggedInKey, false);
  }

  // Estado de autenticación
  static Future<bool> isLoggedIn() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_isLoggedInKey) ?? false;
  }

  static Future<void> setLoggedIn(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_isLoggedInKey, value);
  }

  // Datos del usuario
  static Future<void> saveUser(Map<String, dynamic> userData) async {
    final box = Hive.box('dantexxi_storage');
    await box.put(_userKey, userData);
  }

  static Future<Map<String, dynamic>?> getUser() async {
    final box = Hive.box('dantexxi_storage');
    return box.get(_userKey);
  }

  static Future<void> clearUser() async {
    final box = Hive.box('dantexxi_storage');
    await box.delete(_userKey);
  }

  // Onboarding
  static Future<bool> isOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_onboardingCompletedKey) ?? false;
  }

  static Future<void> setOnboardingCompleted() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_onboardingCompletedKey, true);
  }

  // Limpiar todo (logout)
  static Future<void> clearAll() async {
    await clearTokens();
    await clearUser();
    await setLoggedIn(false);
  }

  // Verificar si el token está expirado (opcional)
  static bool isTokenExpired(String token) {
    try {
      // Decodificar el JWT para verificar la expiración
      final parts = token.split('.');
      if (parts.length != 3) return true;

      final payload = parts[1];
      final normalized = base64Url.normalize(payload);
      final resp = utf8.decode(base64Url.decode(normalized));
      final payloadMap = json.decode(resp);

      final exp = payloadMap['exp'] as int?;
      if (exp == null) return true;

      final expiry = DateTime.fromMillisecondsSinceEpoch(exp * 1000);
      return DateTime.now().isAfter(expiry);
    } catch (e) {
      return true;
    }
  }
}

// Extensión para base64Url
extension Base64UrlExtension on String {
  static String normalize(String input) {
    return input.replaceAll('-', '+').replaceAll('_', '/');
  }
}
