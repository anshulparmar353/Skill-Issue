abstract class QuizEvent {}

class LoadQuiz extends QuizEvent {
  final String skillId;
  LoadQuiz(this.skillId);
}

class AnswerQuestion extends QuizEvent {
  final String questionId;
  final String answer;
  AnswerQuestion(this.questionId, this.answer);
}

class SubmitQuiz extends QuizEvent {
  final String skillId;
  final Map<String,String> answers;

  SubmitQuiz(this.skillId, this.answers);
}
