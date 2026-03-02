import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/auth/data/models/auth_result.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

class LoginUseCase {

  final AuthRepository repo;

  LoginUseCase(this.repo);

  Future<Either<Failure, AuthResult>> call(String email, String password) {
    return repo.login(email: email, password: password);
  }
}
