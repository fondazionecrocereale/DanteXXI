import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_datasource.dart';
import '../../core/services/storage_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthDataSource _authDataSource;

  AuthRepositoryImpl(this._authDataSource);

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      final response = await _authDataSource.login(request);

      // Guardar tokens y datos del usuario
      await StorageService.saveTokens(
        accessToken: response.token,
        refreshToken: response.refreshToken ?? response.token,
      );
      await StorageService.saveUser(response.user.toJson());
      await StorageService.setLoggedIn(true);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      final response = await _authDataSource.register(request);

      // Guardar tokens y datos del usuario
      await StorageService.saveTokens(
        accessToken: response.token,
        refreshToken: response.refreshToken ?? response.token,
      );
      await StorageService.saveUser(response.user.toJson());
      await StorageService.setLoggedIn(true);

      return response;
    } catch (e) {
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      // Llamar al endpoint de logout del backend
      await _authDataSource.logout();
    } catch (e) {
      // Continuar con el logout local incluso si falla el backend
    } finally {
      // Limpiar datos locales
      await StorageService.clearAll();
    }
  }

  @override
  Future<User> getCurrentUser() async {
    try {
      final userData = await StorageService.getUser();
      if (userData != null) {
        return User.fromJson(userData);
      }
      throw Exception('Usuario no encontrado');
    } catch (e) {
      rethrow;
    }
  }

  Future<bool> isAuthenticated() async {
    return await StorageService.isLoggedIn();
  }

  Future<String?> getAccessToken() async {
    return await StorageService.getAccessToken();
  }
}
