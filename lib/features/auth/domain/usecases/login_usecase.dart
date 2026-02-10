import 'package:skill_issue/features/auth/domain/entities/user.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

class LoginUseCase {

  final AuthRepository repo;

  LoginUseCase(this.repo);

  Future<User> call(String email, String password) {
    return repo.login(email: email, password: password);
  }
}
