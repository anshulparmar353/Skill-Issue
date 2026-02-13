
import 'package:skill_issue/features/add_skills/domain/entities/skill_level.dart';

class Skill {

  final String id;
  final String name;
  final SkillLevel level;

  Skill({
    required this.id,
    required this.name,
    required this.level,
  });
}

