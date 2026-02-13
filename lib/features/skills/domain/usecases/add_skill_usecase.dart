import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';

class AddSkillUseCase {

  final SkillsRepository repo;

  AddSkillUseCase(this.repo);

  Future<void> call({
    required String name,
  }) {
    return repo.addSkill(name: name);
  }
}
