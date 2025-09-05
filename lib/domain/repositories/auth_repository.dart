import '../entities/user.dart';
import '../entities/auth_entities.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<void> logout();
  Future<User> getCurrentUser();
}
