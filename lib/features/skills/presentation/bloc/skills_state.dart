import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/skills/domain/entities/skill.dart';

abstract class SkillsState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class SkillsInitial extends SkillsState {}

class SkillsLoading extends SkillsState {}

class SkillsLoaded extends SkillsState {

  final List<Skill>? skills;
  SkillsLoaded(this.skills);

  @override
  List<Object?> get props => [skills];
}

class SkillsError extends SkillsState {
  final String message;

  SkillsError(this.message);

  @override
  List<Object?> get props => [message];
}
