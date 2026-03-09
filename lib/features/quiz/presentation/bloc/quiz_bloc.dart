import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';
import 'package:skill_issue/features/quiz/domain/usecases/get_quiz_questions_usecase.dart';
import 'package:skill_issue/features/quiz/domain/usecases/submit_quiz_usecase.dart';
import 'package:skill_issue/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:skill_issue/features/quiz/presentation/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuizQuestionsUseCase getQuiz;
  final SubmitQuizUseCase submitQuiz;

  late String skillId;
  final Map<String, String> answers = {};
  List<QuizQuestion> questions = [];

  QuizBloc(this.getQuiz, this.submitQuiz) : super(QuizInitial()) {
    on<LoadQuiz>(_load);
    on<AnswerQuestion>(_answer);
    on<SubmitQuiz>(_submit);
  }

  Future<void> _load(LoadQuiz event, Emitter<QuizState> emit) async {
    emit(QuizLoading());

    skillId = event.skillId;
    answers.clear();

    final result = await getQuiz(event.skillId);

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (questionList) {
        questions = questionList;
        emit(QuizLoaded(questions, answers));
    });
  }

  void _answer(AnswerQuestion event, Emitter<QuizState> emit) {
    answers[event.questionId] = event.answer;

    emit(QuizAnswerUpdated(questions, answers));
  }

  Future<void> _submit(SubmitQuiz event, Emitter<QuizState> emit) async {
    emit(QuizLoading());

    final result = await submitQuiz(skillId: skillId, answers: answers);

    result.fold(
      (failure) => emit(QuizError(failure.message)),
      (result) => emit(QuizSubmitted(result)),
    );
  }
}
