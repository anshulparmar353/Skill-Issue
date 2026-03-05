import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';

import '../entities/skill.dart';

abstract class SkillsRepository {

  Future<Either<Failure, List<Skill>>> getSkills();

  Future<void> addSkill({
    required String name,
  });

  Future<Either<Failure, Unit>> deleteSkill(String skillId);
}
