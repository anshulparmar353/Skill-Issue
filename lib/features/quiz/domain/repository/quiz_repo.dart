import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';
import 'package:skill_issue/features/quiz/domain/entities/quiz_result.dart';

abstract class QuizRepository {

  Future<Either<Failure,List<QuizQuestion>>> getQuestions(String skillId);

  Future<Either<Failure, QuizResult>> submitAnswers({
    required String skillId,
    required Map<String, String> answers,
  });
}
