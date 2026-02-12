import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/quiz/domain/usecases/get_quiz_questions_usecase.dart';
import 'package:skill_issue/features/quiz/domain/usecases/submit_quiz_usecase.dart';
import 'package:skill_issue/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:skill_issue/features/quiz/presentation/bloc/quiz_state.dart';

class QuizBloc extends Bloc<QuizEvent, QuizState> {
  final GetQuizQuestionsUseCase getQuiz;
  final SubmitQuizUseCase submitQuiz;

  late String skillId;

  QuizBloc(this.getQuiz, this.submitQuiz) : super(QuizState.initial()) {
    on<LoadQuiz>(_load);
    on<AnswerQuestion>(_answer);
    on<SubmitQuiz>(_submit);
  }

  Future<void> _load(LoadQuiz event, emit) async {
    skillId = event.skillId;

    emit(state.copyWith(loading: true));

    final questions = await getQuiz(skillId);

    emit(state.copyWith(questions: questions, loading: false));
  }

  void _answer(AnswerQuestion event, emit) {
    final updated = Map<String, String>.from(state.answers);

    updated[event.questionId] = event.answer;

    emit(state.copyWith(answers: updated));
  }

  Future<void> _submit(SubmitQuiz event, emit) async {
    emit(state.copyWith(loading: true));

    await submitQuiz(skillId: skillId, answers: state.answers);

    emit(state.copyWith(loading: false, submitted: true));
  }
}
