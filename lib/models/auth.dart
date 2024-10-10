import 'package:mommy_be/models/user.dart';

class Auth {
  final String token;
  final User user;

  Auth({
    required this.token,
    required this.user,
  });

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
      token: json['token'],
      user: User.fromJson(json['user']),
    );
  }
}
