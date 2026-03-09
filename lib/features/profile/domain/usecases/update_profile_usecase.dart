import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/profile/domain/repository/profile_repo.dart';

import '../entities/profile.dart';

class UpdateProfileUseCase {

  final ProfileRepository repository;

  UpdateProfileUseCase(this.repository);

  Future<Either<Failure, Profile>> call({
    required String name,
  }) {

    return repository.updateProfile(
      name: name,
    );
  }
}
