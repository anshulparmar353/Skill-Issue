import 'package:skill_issue/features/skills/domain/entities/skill.dart';

class SkillsState {

  final bool loading;
  final List<Skill> skills;

  SkillsState({
    required this.loading,
    required this.skills,
  });

  factory SkillsState.initial() =>
      SkillsState(
        loading: false,
        skills: [],
      );

  SkillsState copyWith({
    bool? loading,
    List<Skill>? skills,
  }) {
    return SkillsState(
      loading: loading ?? this.loading,
      skills: skills ?? this.skills,
    );
  }
}
