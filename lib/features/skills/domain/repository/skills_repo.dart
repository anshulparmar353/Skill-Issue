import '../entities/skill.dart';

abstract class SkillsRepository {

  Future<List<Skill>> getSkills();

  Future<void> addSkill({
    required String name,
  });

  Future<void> deleteSkill(String skillId);
}
