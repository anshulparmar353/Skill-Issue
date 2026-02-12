import "package:skill_issue/features/auth/data/models/auth_result.dart";

abstract class AuthRepository {

  Future<AuthResult> login({
    required String email,
    required String password
  });

  Future<AuthResult> getCurrentUser();
  
}
