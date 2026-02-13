abstract class MultiQuizEvent {}

class StartQuizFlow extends MultiQuizEvent {
  final List<String> skillIds;

  StartQuizFlow(this.skillIds);
}

class QuizCompletedForSkill extends MultiQuizEvent {}
