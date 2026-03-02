import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/skills/domain/entities/skill.dart';

class SkillsState extends Equatable {

  final bool loading;
  final List<Skill> skills;
  final String? error;

  const SkillsState({
    required this.loading,
    required this.skills,
    required this.error
  });

  factory SkillsState.initial() =>
      SkillsState(
        loading: false,
        skills: [],
        error: "",
      );

  SkillsState copyWith({
    bool? loading,
    List<Skill>? skills,
    String? error,
  }) {
    return SkillsState(
      loading: loading ?? this.loading,
      skills: skills ?? this.skills,
      error: error,
    );
  }
  
  @override
  List<Object?> get props => [loading, skills,error];
}
