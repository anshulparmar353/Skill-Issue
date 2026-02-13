import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';

class DeleteSkillUseCase {

  final SkillsRepository repo;

  DeleteSkillUseCase(this.repo);

  Future<void> call(String id) {
    return repo.deleteSkill(id);
  }
}
