import 'package:skill_issue/features/auth/domain/entities/user.dart';

class AuthResult {
  final User user;
  final bool isNewUser;

  AuthResult({
    required this.user,
    required this.isNewUser,
  });
}
