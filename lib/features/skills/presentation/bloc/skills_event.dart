abstract class SkillsOnboardingEvent {}

class LoadAvailableSkills extends SkillsOnboardingEvent {}

class ToggleSkillSelection extends SkillsOnboardingEvent {
  final String skillId;

  ToggleSkillSelection(this.skillId);
}

class SubmitSelectedSkills extends SkillsOnboardingEvent {}
