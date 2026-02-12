import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';
import 'package:skill_issue/features/quiz/domain/entities/quiz_result.dart';

abstract class QuizRepository {

  Future<List<QuizQuestion>> getQuestions(String skillId);

  Future<QuizResult> submitAnswers({
    required String skillId,
    required Map<String, String> answers,
  });
}
