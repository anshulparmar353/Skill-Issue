import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/auth/data/models/auth_result.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

class GetCurrentUserUseCase {

  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<Either<Failure,AuthResult>> call() {
    return repository.getCurrentUser();
  }
}
