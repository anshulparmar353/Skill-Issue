import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';

class AddSkillUseCase {
  final SkillsRepository repo;

  AddSkillUseCase(this.repo);

  Future<Either<Failure, Unit>> call({required String name}) async {
    await repo.addSkill(name: name);

    return Right(unit);
  }
}
