import 'package:skill_issue/features/add_skills/domain/entities/skill_level.dart';

class QuizResult {

  final String skillId;
  final SkillLevel level;

  QuizResult({
    required this.skillId,
    required this.level,
  });
}
