import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';
import '../entities/skill.dart';


class GetSkillsUseCase {

  final SkillsRepository repo;

  GetSkillsUseCase(this.repo);

  Future<List<Skill>> call() {
    return repo.getSkills();
  }
}
