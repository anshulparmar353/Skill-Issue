import "package:dartz/dartz.dart";
import "package:skill_issue/core/errors/failures.dart";
import "package:skill_issue/features/auth/data/models/auth_result.dart";

abstract class AuthRepository {

  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password
  });

  Future<Either<Failure, AuthResult>> getCurrentUser();

  Future<Either<Failure, AuthResult>>  register({
    required String email,
    required String password,
    required String name,
  });

  Future<Either<Failure, Unit>> logout();
  
}
