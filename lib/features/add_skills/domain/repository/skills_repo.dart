import 'package:skill_issue/features/add_skills/domain/entities/skill.dart';

abstract class SkillsRepository {

  Future<List<Skill>> getAvailableSkills();

  Future<void> submitUserSkills(List<String> skillIds);
}
