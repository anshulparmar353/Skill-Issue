abstract class SkillsEvent {}

class LoadSkills extends SkillsEvent {}

class AddSkill extends SkillsEvent {
  final String skillName;

  AddSkill(this.skillName);
}

class DeleteSkill extends SkillsEvent {
  final String skillId;

  DeleteSkill(this.skillId);
}
