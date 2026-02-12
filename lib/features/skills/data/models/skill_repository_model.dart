import 'package:skill_issue/features/auth/data/models/user_model.dart';

class AuthResponseModel {

  final String accessToken;
  final String refreshToken;
  final UserModel user;
  final bool isNewUser;

  AuthResponseModel({
    required this.accessToken,
    required this.refreshToken,
    required this.user,
    required this.isNewUser,
  });

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) {
    return AuthResponseModel(
      accessToken: json["access_token"],
      refreshToken: json["refresh_token"],
      user: UserModel.fromJson(json["user"]),
      isNewUser: json["is_new_user"] ?? false,
    );
  }
}
