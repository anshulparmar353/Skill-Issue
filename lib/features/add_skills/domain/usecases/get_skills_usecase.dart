import 'package:skill_issue/features/add_skills/domain/entities/skill.dart';
import 'package:skill_issue/features/add_skills/domain/repository/skills_repo.dart';

class GetAvailableSkillsUseCase {

  final SkillsRepository repo;

  GetAvailableSkillsUseCase(this.repo);

  Future<List<Skill>> call() {
    return repo.getAvailableSkills();
  }
}
