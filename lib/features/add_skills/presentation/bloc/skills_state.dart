import 'package:skill_issue/features/add_skills/domain/entities/skill.dart';

class SkillsOnboardingState {
  final List<Skill> skills;
  final Set<String> selectedIds;
  final bool loading;
  final bool submitted;

  SkillsOnboardingState({
    required this.skills,
    required this.selectedIds,
    required this.loading,
    required this.submitted,
  });

  factory SkillsOnboardingState.initial() => SkillsOnboardingState(
    skills: [],
    selectedIds: {},
    loading: false,
    submitted: false,
  );

  SkillsOnboardingState copyWith({
    List<Skill>? skills,
    Set<String>? selectedIds,
    bool? loading,
    bool? submitted,
  }) {
    return SkillsOnboardingState(
      skills: skills ?? this.skills,
      selectedIds: selectedIds ?? this.selectedIds,
      loading: loading ?? this.loading,
      submitted: submitted ?? this.submitted,
    );
  }
}
