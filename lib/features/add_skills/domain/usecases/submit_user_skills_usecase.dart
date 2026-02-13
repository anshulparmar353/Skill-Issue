import 'package:skill_issue/features/add_skills/domain/repository/skills_repo.dart';

class SubmitUserSkillsUseCase {

  final SkillsRepository repo;

  SubmitUserSkillsUseCase(this.repo);

  Future<void> call(List<String> ids) {
    return repo.submitUserSkills(ids);
  }
}
