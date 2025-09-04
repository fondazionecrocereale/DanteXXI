import 'package:dio/dio.dart';
import 'storage_service.dart';
import '../constants/app_constants.dart';

class TokenRefreshService {
  static final Dio _dio = Dio();
  
  static Future<String?> refreshAccessToken() async {
    try {
      final refreshToken = await StorageService.getRefreshToken();
      if (refreshToken == null) return null;
      
      final response = await _dio.post(
        '${AppConstants.baseUrl}/auth/refresh',
        data: {
          'refreshToken': refreshToken,
        },
        options: Options(
          headers: {'Content-Type': 'application/json'},
        ),
      );
      
      if (response.statusCode == 200) {
        final newAccessToken = response.data['accessToken'];
        final newRefreshToken = response.data['refreshToken'];
        
        await StorageService.saveTokens(newAccessToken, newRefreshToken);
        await StorageService.updateTokenTimestamp();
        
        return newAccessToken;
      }
    } catch (e) {
      // Si falla el refresh, limpiar tokens
      await StorageService.clearAll();
    }
    return null;
  }
  
  static Future<bool> tryRefreshToken() async {
    final shouldRefresh = await StorageService.shouldRefreshToken();
    if (shouldRefresh) {
      final newToken = await refreshAccessToken();
      return newToken != null;
    }
    return true;
  }
}

