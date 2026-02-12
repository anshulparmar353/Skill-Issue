import 'package:skill_issue/features/quiz/data/datasources/quiz_api.dart';
import 'package:skill_issue/features/quiz/domain/repository/quiz_repo.dart';

import '../../domain/entities/quiz_question.dart';
import '../../domain/entities/quiz_result.dart';

import '../models/quiz_question_model.dart';
import '../models/quiz_result_model.dart';

class QuizRepoImpl implements QuizRepository {

  final QuizApi api;

  QuizRepoImpl(this.api);

  @override
  Future<List<QuizQuestion>> getQuestions(String skillId) async {

    try {

      final List<QuizQuestionModel> models =
          await api.getQuestions(skillId);

      return models;

    } catch (e) {

      throw Exception("Failed to load quiz questions");
    }
  }

  @override
  Future<QuizResult> submitAnswers({
    required String skillId,
    required Map<String, String> answers,
  }) async {

    try {

      final QuizResultModel result =
          await api.submitQuiz(
            skillId: skillId,
            answers: answers,
          );

      return result;

    } catch (e) {

      throw Exception("Failed to submit quiz");
    }
  }

}
