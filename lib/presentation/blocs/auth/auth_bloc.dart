import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';
import '../../../domain/entities/auth_entities.dart';
import '../../../domain/usecases/auth_usecases.dart';
import 'auth_event.dart';
import 'auth_state.dart';
import '../../../core/services/storage_service.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase _loginUseCase;
  final RegisterUseCase _registerUseCase;
  final LogoutUseCase _logoutUseCase;
  final GetCurrentUserUseCase _getCurrentUserUseCase;

  AuthBloc({
    required LoginUseCase loginUseCase,
    required RegisterUseCase registerUseCase,
    required LogoutUseCase logoutUseCase,
    required GetCurrentUserUseCase getCurrentUserUseCase,
  }) : _loginUseCase = loginUseCase,
       _registerUseCase = registerUseCase,
       _logoutUseCase = logoutUseCase,
       _getCurrentUserUseCase = getCurrentUserUseCase,
       super(AuthInitial()) {
    on<AuthLoginRequested>(_onAuthLoginRequested);
    on<AuthRegisterRequested>(_onAuthRegisterRequested);
    on<AuthLogoutRequested>(_onAuthLogoutRequested);
    on<AuthCheckRequested>(_onAuthCheckRequested);
  }

  Future<void> _onAuthLoginRequested(
    AuthLoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final authResponse = await _loginUseCase(event.request);

      // Guardar datos del usuario en almacenamiento local
      print(
        '💾 AuthBloc._onAuthLoginRequested - Guardando usuario: ${authResponse.user['email']}',
      );
      await StorageService.saveUser(authResponse.user);
      print(
        '💾 AuthBloc._onAuthLoginRequested - Guardando token: ${authResponse.token.substring(0, 20)}...',
      );
      await StorageService.saveTokens(authResponse.token, '');
      print('✅ AuthBloc._onAuthLoginRequested - Datos guardados exitosamente');

      emit(AuthAuthenticated(authResponse.user, authResponse.token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthRegisterRequested(
    AuthRegisterRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final authResponse = await _registerUseCase(event.request);

      // Guardar datos del usuario en almacenamiento local
      await StorageService.saveUser(authResponse.user);
      await StorageService.saveTokens(authResponse.token, '');

      emit(AuthAuthenticated(authResponse.user, authResponse.token));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthLogoutRequested(
    AuthLogoutRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      await _logoutUseCase();
      await StorageService.clearAll();
      emit(AuthUnauthenticated());
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }

  Future<void> _onAuthCheckRequested(
    AuthCheckRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      // Primero verificar si hay token local
      final token = await StorageService.getAccessToken();
      print(
        '🔍 AuthBloc._onAuthCheckRequested - Token local: ${token != null ? "EXISTE" : "NO EXISTE"}',
      );
      if (token == null) {
        print('🔍 AuthBloc._onAuthCheckRequested - No hay token local');
        emit(AuthUnauthenticated());
        return;
      }

      // Verificar si el token está expirado
      if (await StorageService.isTokenExpired(token)) {
        print('🔍 AuthBloc._onAuthCheckRequested - Token expirado');
        await StorageService.clearAll();
        emit(AuthUnauthenticated());
        return;
      }

      // Intentar obtener usuario del backend
      try {
        final user = await _getCurrentUserUseCase();
        print(
          '✅ AuthBloc._onAuthCheckRequested - Usuario obtenido del backend: ${user.email}',
        );
        emit(AuthAuthenticated(user.toJson(), token));
      } catch (e) {
        // Si falla el backend pero tenemos token válido, usar datos locales
        print('⚠️ AuthBloc._onAuthCheckRequested - Error del backend: $e');
        print(
          '🔄 AuthBloc._onAuthCheckRequested - Intentando usar datos locales...',
        );

        // Intentar obtener datos del usuario desde SharedPreferences
        final userData = await StorageService.getUserData();
        if (userData != null) {
          print(
            '✅ AuthBloc._onAuthCheckRequested - Usando datos locales: ${userData['email']}',
          );
          emit(AuthAuthenticated(userData, token));
        } else {
          print(
            '❌ AuthBloc._onAuthCheckRequested - No hay datos locales disponibles',
          );
          await StorageService.clearAll();
          emit(AuthUnauthenticated());
        }
      }
    } catch (e) {
      print('❌ AuthBloc._onAuthCheckRequested - Error general: $e');
      emit(AuthUnauthenticated());
    }
  }
}
