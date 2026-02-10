import "package:skill_issue/features/auth/domain/entities/user.dart";

abstract class AuthRepository {

  Future<User> login({
    required String email,
    required String password
  });

  Future<User> getCurrentUser();
  
}
