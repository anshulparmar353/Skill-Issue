import 'package:skill_issue/features/skills/data/datasources/skills_api.dart';
import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';
import '../../domain/entities/skill.dart';

class SkillsRepoImpl implements SkillsRepository {

  final SkillsApi api;

  SkillsRepoImpl(this.api);

  @override
  Future<List<Skill>> getSkills() async {

    try {

      final skills = await api.getSkills();
      return skills;

    } catch (e) {

      throw Exception("Failed to load skills");
    }
  }

  @override
  Future<void> addSkill({
    required String name,
  }) async {

    try {

      await api.addSkill(name: name);

    } catch (e) {

      throw Exception("Failed to add skill");
    }
  }

  @override
  Future<void> deleteSkill(String skillId) async {

    try {

      await api.deleteSkill(skillId);

    } catch (e) {

      throw Exception("Failed to delete skill");
    }
  }
}
