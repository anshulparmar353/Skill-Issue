import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';

class DeleteSkillUseCase {
  final SkillsRepository repo;

  DeleteSkillUseCase(this.repo);

  Future<Either<Failure, Unit>> call(String id) async {
    await repo.deleteSkill(id);

    return Right(unit);
  }
}
