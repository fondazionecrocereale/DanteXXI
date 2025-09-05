import '../../domain/entities/user.dart';
import '../../domain/entities/auth_entities.dart';
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
        response.token,
        response.refreshToken ?? response.token,
      );
      await StorageService.saveUser(response.user);
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
        response.token,
        response.refreshToken ?? response.token,
      );
      await StorageService.saveUser(response.user);
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

  @override
  Future<bool> isAuthenticated() async {
    final isLoggedIn = await StorageService.isLoggedIn();
    final token = await StorageService.getAccessToken();

    if (!isLoggedIn || token == null) return false;

    if (await StorageService.isTokenExpired(token)) {
      await StorageService.clearAll();
      return false;
    }

    return true;
  }

  @override
  Future<String?> getAccessToken() async {
    final token = await StorageService.getAccessToken();
    if (token != null && await StorageService.isTokenExpired(token)) {
      await StorageService.clearAll();
      return null;
    }
    return token;
  }
}
