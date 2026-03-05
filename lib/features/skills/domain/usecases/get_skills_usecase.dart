import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/add_skills/domain/repository/skills_repo.dart';

import '../entities/skill.dart';

class GetSkillsUseCase {
  final SkillsRepository repo;

  GetSkillsUseCase(this.repo);

  Future<Either<Failure, List<Skill>>> call() async {
    return await repo.getSkills();
  }
}