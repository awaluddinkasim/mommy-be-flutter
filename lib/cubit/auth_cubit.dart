import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/auth_state.dart';
import 'package:mommy_be/models/user.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/auth_service.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthService _authService = AuthService();

  AuthCubit() : super(AuthInitial()) {
    checkAuth();
  }

  User get user => (state as AuthSuccess).auth.user;

  Future<void> checkAuth() async {
    emit(AuthLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      if (token != null) {
        final result = await _authService.getUser(token);

        OneSignal.login(result.user.email);
        emit(AuthSuccess(result));
      } else {
        OneSignal.logout();
        emit(AuthInitial());
      }
    } catch (e) {
      OneSignal.logout();
      await Constants.storage.delete(key: 'token');
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());

    try {
      final auth = await _authService.login(email, password);

      await Constants.storage.write(key: 'token', value: auth.token);

      OneSignal.login(auth.user.email);

      emit(AuthSuccess(auth));
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> logout() async {
    emit(AuthLoading());

    try {
      final token = await Constants.storage.read(key: 'token');

      await _authService.logout(token!);
      await Constants.storage.delete(key: 'token');

      OneSignal.logout();

      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> updateUser(User user) async {
    final currentState = state;

    if (currentState is AuthSuccess) {
      emit(AuthSuccess(currentState.auth.copyWith(user: user)));
    }
  }
}
