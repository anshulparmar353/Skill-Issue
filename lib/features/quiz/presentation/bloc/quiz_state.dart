import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';
import 'package:skill_issue/features/quiz/domain/entities/quiz_result.dart';

abstract class QuizState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class QuizInitial extends QuizState {}

class QuizLoading extends QuizState {}

class QuizLoaded extends QuizState {
  final List<QuizQuestion> questions;
  final Map<String, String> answers;

  QuizLoaded(this.questions, this.answers);

  @override
  List<Object?> get props => [questions, answers];
}

class QuizSubmitting extends QuizState {}

class QuizSubmitted extends QuizState {
  final QuizResult result;

  QuizSubmitted(this.result);

  @override
  List<Object?> get props => [result];
}

class QuizAnswerUpdated extends QuizState {
  final List<QuizQuestion> questions;
  final Map<String, String> answers;

  QuizAnswerUpdated(this.questions, this.answers);

  @override
  List<Object?> get props => [questions, answers];
}

class QuizError extends QuizState {
  final String message;

  QuizError(this.message);

  @override
  List<Object?> get props => [message];
}
