import 'package:equatable/equatable.dart';
import 'package:mommy_be/models/auth.dart';

class AuthState extends Equatable {
  const AuthState();

  @override
  List<Object> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class AuthSuccess extends AuthState {
  final Auth auth;

  const AuthSuccess(this.auth);

  @override
  List<Object> get props => [auth];
}

class AuthFailed extends AuthState {
  final String error;

  const AuthFailed(this.error);

  @override
  List<Object> get props => [error];
}
