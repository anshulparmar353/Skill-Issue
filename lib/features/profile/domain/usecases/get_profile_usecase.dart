import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/profile/domain/repository/profile_repo.dart';

import '../entities/profile.dart';

class GetProfileUseCase {

  final ProfileRepository repository;

  GetProfileUseCase(this.repository);

  Future<Either<Failure, Profile>> call() {
    return repository.getProfile();
  }
}
