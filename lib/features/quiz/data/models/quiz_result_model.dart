import 'package:skill_issue/features/quiz/domain/entities/quiz_result.dart';
import 'package:skill_issue/features/skills/domain/entities/skill_level.dart';

class QuizResultModel extends QuizResult {
  QuizResultModel({required super.skillId, required super.level});

  factory QuizResultModel.fromJson(Map<String, dynamic> json) {
    return QuizResultModel(
      skillId: json["skillId"].toString(),
      level: _levelFromString(json["level"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "skill_id": skillId,
      "level": _levelToString(level),
    };
  }

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
