import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_event.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_state.dart';

class MultiQuizBloc extends Bloc<MultiQuizEvent,MultiQuizState> {

  MultiQuizBloc() : super(MultiQuizState.initial()) {

    on<StartQuizFlow>(_start);
    on<QuizCompletedForSkill>(_next);
  }

  void _start(
    StartQuizFlow event,
    Emitter<MultiQuizState> emit,
  ) {

    emit(
      state.copyWith(
        skillQueue: event.skillIds,
        currentIndex: 0,
        completed: false,
      ),
    );
  }

  void _next(
    QuizCompletedForSkill event,
    Emitter<MultiQuizState> emit,
  ) {

    if (state.hasNext) {

      emit(
        state.copyWith(
          currentIndex: state.currentIndex + 1,
        ),
      );

    } else {

      emit(
        state.copyWith(
          completed: true,
        ),
      );
    }
  }
}
