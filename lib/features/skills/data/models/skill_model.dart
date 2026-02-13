import 'package:skill_issue/features/add_skills/domain/entities/skill_level.dart';
import '../../domain/entities/skill.dart';

class SkillModel extends Skill {

  SkillModel({
    required super.id,
    required super.name,
    required super.level,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {

    return SkillModel(
      id: json["id"].toString(),
      name: json["name"] ?? "",
      level: _levelFromString(json["level"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "level": _levelToString(level),
    };
  }

  /// Enum Mapping

  static SkillLevel _levelFromString(String level) {

    switch (level.toLowerCase()) {
      case "beginner":
        return SkillLevel.beginner;
      case "intermediate":
        return SkillLevel.intermediate;
      case "advanced":
        return SkillLevel.advanced;
      default:
        return SkillLevel.beginner;
    }
  }

  static String _levelToString(SkillLevel level) {

    switch (level) {
      case SkillLevel.beginner:
        return "beginner";
      case SkillLevel.intermediate:
        return "intermediate";
      case SkillLevel.advanced:
        return "advanced";
    }
  }
}
