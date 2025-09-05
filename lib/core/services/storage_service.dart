import 'package:shared_preferences/shared_preferences.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'dart:convert';

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
  static Future<void> saveTokens(
    String accessToken,
    String refreshToken,
  ) async {
    print(
      '💾 StorageService.saveTokens - Guardando token: ${accessToken.substring(0, 20)}...',
    );
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('access_token', accessToken);
    await prefs.setString('refresh_token', refreshToken);
    await prefs.setString(
      'token_timestamp',
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
    print('✅ StorageService.saveTokens - Token guardado exitosamente');
  }

  static Future<String?> getAccessToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    print(
      '🔍 StorageService.getAccessToken - Token: ${token != null ? "EXISTE" : "NO EXISTE"}',
    );
    return token;
  }

  static Future<String?> getRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('refresh_token');
  }

  static Future<bool> shouldRefreshToken() async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString('token_timestamp');
    if (timestamp == null) return true;

    final tokenTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final now = DateTime.now();
    final difference = now.difference(tokenTime);

    // Renovar si han pasado más de 23 horas (antes de que expire)
    return difference.inHours >= 23;
  }

  static Future<void> updateTokenTimestamp() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(
      'token_timestamp',
      DateTime.now().millisecondsSinceEpoch.toString(),
    );
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

  // Alias para getUser (compatibilidad)
  static Future<Map<String, dynamic>?> getUserData() async {
    return await getUser();
  }

  // Verificar si el token está expirado
  static Future<bool> isTokenExpired(String token) async {
    final prefs = await SharedPreferences.getInstance();
    final timestamp = prefs.getString('token_timestamp');
    if (timestamp == null) return true;

    final tokenTime = DateTime.fromMillisecondsSinceEpoch(int.parse(timestamp));
    final now = DateTime.now();
    final difference = now.difference(tokenTime);

    // Considerar expirado si han pasado más de 24 horas
    return difference.inHours >= 24;
  }

  // Verificar si el token está expirado (versión síncrona)
  static bool isTokenExpiredSync(String token) {
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
