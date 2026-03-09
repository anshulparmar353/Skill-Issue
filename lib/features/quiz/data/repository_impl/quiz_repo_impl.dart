import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/errors/failures.dart';
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
  Future<Either<Failure, List<QuizQuestion>>> getQuestions(
    String skillId,
  ) async {
    try {
      final List<QuizQuestionModel> models = await api.getQuestions(skillId);

      return Right(models);
    } on ServerException {
      return const Left(ServerFailure("Server error occurred"));
    } on NetworkException {
      return const Left(NetworkFailure("No internet connection"));
    } on CacheException {
      return const Left(CacheFailure("Cache error"));
    } catch (_) {
      return const Left(UnknownFailure("Unexpected error"));
    }
  }

  @override
  Future<Either<Failure, QuizResult>> submitAnswers({
    required String skillId,
    required Map<String, String> answers,
  }) async {
    try {
      final QuizResultModel result = await api.submitQuiz(
        skillId: skillId,
        answers: answers,
      );

      return Right(result);
    } on ServerException {
      return const Left(ServerFailure("Server error occurred"));
    } on NetworkException {
      return const Left(NetworkFailure("No internet connection"));
    } on CacheException {
      return const Left(CacheFailure("Cache error"));
    } catch (_) {
      return const Left(UnknownFailure("Unexpected error"));
    }
  }
}
