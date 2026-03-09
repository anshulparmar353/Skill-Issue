import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:skill_issue/core/routes/app_go_router.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_bloc.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_event.dart';
import 'package:skill_issue/features/multi_quiz/presentation/bloc/multi_quiz_state.dart';
import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';
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

  Widget _buildQuestions(
    List<QuizQuestion> questions,
    Map<String, String> answers,
  ) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: ListView.builder(
        itemCount: questions.length,
        itemBuilder: (_, index) {
          final q = questions[index];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),

              Text(
                q.question,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              ...q.options.map((option) {
                return RadioListTile(
                  key: ValueKey(option),
                  value: option,
                  groupValue: answers[q.id],
                  onChanged: (value) {
                    context.read<QuizBloc>().add(AnswerQuestion(q.id, value!));
                  },
                  title: Text(option),
                );
              }),
            ],
          );
        },
      ),
    );
  }

  Widget _buildSubmitButton() {
    return BlocBuilder<QuizBloc, QuizState>(
      builder: (context, state) {
        late Map<String,String> answers;
        late List<QuizQuestion> questions;

        if (state is QuizLoaded || state is QuizAnswerUpdated) {
          if (state is QuizLoaded) {
            answers= state.answers;
            questions = state.questions;
          }

          if (state is QuizAnswerUpdated) {
            answers = state.answers;
            questions = state.questions;
          }

          final isComplete = questions.every((q) => answers.containsKey(q.id));

          return Padding(
            padding: const EdgeInsets.all(16),
            child: ElevatedButton(
              onPressed: isComplete
                  ? () {
                      final flowState = context.read<MultiQuizBloc>().state;

                      context.read<QuizBloc>().add(
                        SubmitQuiz(flowState.currentSkillId, answers),
                      );
                    }
                  : null,
              child: const Text("Submit"),
            ),
          );
        }
        return const SizedBox();
      },
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
              if (quizState is QuizSubmitted) {
                context.read<MultiQuizBloc>().add(QuizCompletedForSkill());

                _loadQuizForCurrentSkill();
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
                  if (state is QuizLoading) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (state is QuizError) {
                    return const Center(child: Text("Failed to load"));
                  }

                  if (state is QuizLoaded) {
                    return _buildQuestions(state.questions, state.answers);
                  }

                  if (state is QuizAnswerUpdated) {
                    return _buildQuestions(state.questions, state.answers);
                  }

                  return const SizedBox();
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
