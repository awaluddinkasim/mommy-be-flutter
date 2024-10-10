import 'package:mommy_be/models/auth.dart';
import 'package:mommy_be/shared/dio.dart';

class AuthService {
  Future<Auth> getUser(String token) async {
    final response = await Request.get('/user', headers: {
      'Authorization': 'Bearer $token',
    });

    return Auth.fromJson({...response, 'token': token});
  }

  Future<String> updatePassword(String token, String password) async {
    final response = await Request.put('/password', data: {
      'password': password
    }, headers: {
      'Authorization': 'Bearer $token',
    });

    return response['message'];
  }

  Future<Auth> login(String email, String password) async {
    final response = await Request.post('/login', data: {
      'email': email,
      'password': password,
    });

    return Auth.fromJson(response['data']);
  }

  Future<bool> logout(String token) async {
    final response = await Request.post('/logout', headers: {
      'Authorization': 'Bearer $token',
    });

    return response['status'] == "success";
  }
}
