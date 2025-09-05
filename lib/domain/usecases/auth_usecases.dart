import '../entities/user.dart';
import '../entities/auth_entities.dart';
import '../repositories/auth_repository.dart';

abstract class LoginUseCase {
  Future<AuthResponse> call(LoginRequest request);
}

abstract class RegisterUseCase {
  Future<AuthResponse> call(RegisterRequest request);
}

abstract class LogoutUseCase {
  Future<void> call();
}

abstract class GetCurrentUserUseCase {
  Future<User> call();
}

class LoginUseCaseImpl implements LoginUseCase {
  final AuthRepository _authRepository;

  LoginUseCaseImpl(this._authRepository);

  @override
  Future<AuthResponse> call(LoginRequest request) async {
    // Validaciones básicas
    if (request.email.isEmpty || request.password.isEmpty) {
      throw Exception('Email y contraseña son requeridos');
    }

    if (!request.email.contains('@')) {
      throw Exception('Email inválido');
    }

    if (request.password.length < 6) {
      throw Exception('La contraseña debe tener al menos 6 caracteres');
    }

    return await _authRepository.login(request);
  }
}

class RegisterUseCaseImpl implements RegisterUseCase {
  final AuthRepository _authRepository;

  RegisterUseCaseImpl(this._authRepository);

  @override
  Future<AuthResponse> call(RegisterRequest request) async {
    // Validaciones básicas
    if (request.email.isEmpty ||
        request.password.isEmpty ||
        request.firstName.isEmpty ||
        request.lastName.isEmpty) {
      throw Exception('Todos los campos son requeridos');
    }

    if (!request.email.contains('@')) {
      throw Exception('Email inválido');
    }

    if (request.password.length < 6) {
      throw Exception('La contraseña debe tener al menos 6 caracteres');
    }

    if (request.firstName.length < 2) {
      throw Exception('El nombre debe tener al menos 2 caracteres');
    }

    if (request.lastName.length < 2) {
      throw Exception('El apellido debe tener al menos 2 caracteres');
    }

    return await _authRepository.register(request);
  }
}

class LogoutUseCaseImpl implements LogoutUseCase {
  final AuthRepository _authRepository;

  LogoutUseCaseImpl(this._authRepository);

  @override
  Future<void> call() async {
    await _authRepository.logout();
  }
}

class GetCurrentUserUseCaseImpl implements GetCurrentUserUseCase {
  final AuthRepository _authRepository;

  GetCurrentUserUseCaseImpl(this._authRepository);

  @override
  Future<User> call() async {
    return await _authRepository.getCurrentUser();
  }
}
