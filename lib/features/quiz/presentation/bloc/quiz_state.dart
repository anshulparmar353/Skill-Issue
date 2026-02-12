import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';

class QuizState {

  final List<QuizQuestion> questions;
  final Map<String, String> answers;
  final bool loading;
  final bool submitted;

  QuizState({
    required this.questions,
    required this.answers,
    required this.loading,
    required this.submitted,
  });

  factory QuizState.initial() =>
      QuizState(
        questions: [],
        answers: {},
        loading: false,
        submitted: false,
      );

  QuizState copyWith({
    List<QuizQuestion>? questions,
    Map<String, String>? answers,
    bool? loading,
    bool? submitted,
  }) {
    return QuizState(
      questions: questions ?? this.questions,
      answers: answers ?? this.answers,
      loading: loading ?? this.loading,
      submitted: submitted ?? this.submitted,
    );
  }
}
