import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mommy_be/cubit/auth_state.dart';
import 'package:mommy_be/models/user.dart';
import 'package:mommy_be/shared/constants.dart';
import 'package:mommy_be/shared/services/auth_service.dart';

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

        emit(AuthSuccess(result));
      } else {
        emit(AuthInitial());
      }
    } catch (e) {
      await Constants.storage.delete(key: 'token');
      emit(AuthFailed(e.toString()));
    }
  }

  Future<void> login(String email, String password) async {
    emit(AuthLoading());
    try {
      final auth = await _authService.login(email, password);

      await Constants.storage.write(key: 'token', value: auth.token);

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
      emit(AuthInitial());
    } catch (e) {
      emit(AuthFailed(e.toString()));
    }
  }
}
