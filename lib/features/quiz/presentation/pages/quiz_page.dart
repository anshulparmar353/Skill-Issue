import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_issue/core/routes/app_go_router.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_bloc.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_event.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_state.dart';
import 'package:skill_issue/features/quiz/presentation/bloc/quiz_bloc.dart';
import 'package:skill_issue/features/quiz/presentation/bloc/quiz_event.dart';
import 'package:skill_issue/features/quiz/presentation/bloc/quiz_state.dart';

class QuizPage extends StatefulWidget {
  const QuizPage({super.key});

  @override
  State<QuizPage> createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  @override
  void initState() {
    super.initState();
    _loadQuizForCurrentSkill();
  }

  void _loadQuizForCurrentSkill() {
    final flowState = context.read<MultiQuizBloc>().state;

    context.read<QuizBloc>().add(LoadQuiz(flowState.currentSkillId));
  }

  Widget _buildHeader() {
    final flowState = context.watch<MultiQuizBloc>().state;

    return Column(
      children: [
        Text(
          flowState.currentSkillId.toUpperCase(),
          style: const TextStyle(fontSize: 24),
        ),

        Text("${flowState.currentIndex + 1} / ${flowState.skillQueue.length}"),
      ],
    );
  }

  Widget _buildQuestions(QuizState state) {
    return ListView.builder(
      itemCount: state.questions.length,
      itemBuilder: (_, index) {
        final q = state.questions[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(q.question),

            ...q.options.map((option) {
              return RadioListTile(
                value: option,
                groupValue: state.answers[q.id],
                onChanged: (value) {
                  context.read<QuizBloc>().add(AnswerQuestion(q.id, value!));
                },
                title: Text(option),
              );
            }),
          ],
        );
      },
    );
  }

  Widget _buildSubmitButton() {
    return ElevatedButton(
      onPressed: () {
        final flowState = context.read<MultiQuizBloc>().state;
        final quizState = context.read<QuizBloc>().state;

        context.read<QuizBloc>().add(
          SubmitQuiz(flowState.currentSkillId, quizState.answers),
        );
      },

      child: const Text("Submit"),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocListener(
        listeners: [
          BlocListener<MultiQuizBloc, MultiQuizState>(
            listener: (context, flowState) {
              if (flowState.completed) {
                context.go(AppRoutes.homeScreen);
              }
            },
          ),

          BlocListener<QuizBloc, QuizState>(
            listener: (context, quizState) {
              if (quizState.submitted) {
                context.read<MultiQuizBloc>().add(QuizCompletedForSkill());
              }
            },
          ),
        ],

        child: Column(
          children: [
            _buildHeader(),

            Expanded(
              child: BlocBuilder<QuizBloc, QuizState>(
                builder: (context, state) {
                  if (state.loading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  return _buildQuestions(state);
                },
              ),
            ),

            _buildSubmitButton(),
          ],
        ),
      ),
    );
  }
}
