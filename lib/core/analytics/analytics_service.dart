class AnalyticsService {

  void trackSkillAdded(String skill) {
    print("Skill added: $skill");
  }

  void trackSkillDeleted(String skill) {
    print("Skill deleted: $skill");
  }

  void trackSkillViewed(String skill) {
    print("Skill viewed: $skill");
  }

}