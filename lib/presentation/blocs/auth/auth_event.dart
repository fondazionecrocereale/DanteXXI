import 'package:equatable/equatable.dart';

import '../../../domain/entities/user.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class AuthLoginRequested extends AuthEvent {
  final LoginRequest request;

  const AuthLoginRequested(this.request);

  @override
  List<Object> get props => [request];
}

class AuthRegisterRequested extends AuthEvent {
  final RegisterRequest request;

  const AuthRegisterRequested(this.request);

  @override
  List<Object> get props => [request];
}

class AuthLogoutRequested extends AuthEvent {}

class AuthCheckRequested extends AuthEvent {}
