import 'package:dio/dio.dart';
import '../../domain/entities/user.dart';
import '../../domain/entities/auth_entities.dart';
import '../../core/network/dio_client.dart';
import '../../core/services/did_service.dart';

abstract class AuthDataSource {
  Future<AuthResponse> login(LoginRequest request);
  Future<AuthResponse> register(RegisterRequest request);
  Future<void> logout();
}

class AuthDataSourceImpl implements AuthDataSource {
  final DioClient _dioClient;
  static const String _baseUrl = 'https://dantexxi-api.onrender.com';

  AuthDataSourceImpl(this._dioClient);

  @override
  Future<AuthResponse> login(LoginRequest request) async {
    try {
      // Intentar login real primero
      final response = await _dioClient.dio.post(
        '$_baseUrl/auth/login',
        data: request.toJson(),
      );

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      // Si falla, usar autenticación temporal para testing
      if (e is DioException && e.response?.statusCode == 500) {
        return _createMockAuthResponse(request.email, request.password);
      }
      rethrow;
    }
  }

  @override
  Future<AuthResponse> register(RegisterRequest request) async {
    try {
      // Generar DID y wallet address automáticamente
      final did = DIDService.generateDID(request.email);
      final walletAddress = DIDService.generateWalletAddress(did);

      // Agregar campos Web3 al request
      final requestData = request.toJson();
      requestData['did'] = did;
      requestData['wallet_address'] = walletAddress;
      requestData['is_web3_enabled'] = true;

      // Intentar registro real primero
      final response = await _dioClient.dio.post(
        '$_baseUrl/auth/register',
        data: requestData,
      );

      return AuthResponse.fromJson(response.data);
    } catch (e) {
      // Si falla, usar autenticación temporal para testing
      if (e is DioException && e.response?.statusCode == 500) {
        return _createMockAuthResponse(request.email, request.password);
      }
      rethrow;
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _dioClient.dio.post('$_baseUrl/auth/logout');
    } catch (e) {
      // Continuar con logout local incluso si falla el backend
    }
  }

  // Método temporal para testing mientras se resuelve el backend
  AuthResponse _createMockAuthResponse(String email, String password) {
    final mockUser = User(
      id: 'mock_${DateTime.now().millisecondsSinceEpoch}',
      email: email,
      firstName: email.split('@')[0],
      lastName: 'Usuario',
      avatar: null,
      level: 'A1',
      totalXP: 0,
      currentStreak: 0,
      longestStreak: 0,
      lessonsCompleted: 0,
      exercisesCompleted: 0,
      wordsLearned: 0,
      joinDate: DateTime.now(),
      isPremium: false,
      country: 'Argentina',
      credits: '0',
      currency: 'ARS',
      intereses: ['italiano', 'cultura'],
      language: 'es',
      lastSignIn: DateTime.now(),
      uid: 'mock_uid_${DateTime.now().millisecondsSinceEpoch}',
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    return AuthResponse(
      user: mockUser.toJson(),
      token: 'mock_token_${DateTime.now().millisecondsSinceEpoch}',
      refreshToken: 'mock_refresh_${DateTime.now().millisecondsSinceEpoch}',
      message:
          '⚠️ Modo de prueba activado - Backend temporalmente no disponible',
    );
  }
}
