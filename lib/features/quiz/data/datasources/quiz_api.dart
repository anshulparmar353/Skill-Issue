import 'package:dio/dio.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/network/api_endpoints.dart';
import 'package:skill_issue/core/network/dio_client.dart';
import 'package:skill_issue/features/quiz/data/models/quiz_question_model.dart';
import 'package:skill_issue/features/quiz/data/models/quiz_result_model.dart';

class QuizApi {
  final DioClient dio;

  QuizApi(this.dio);

  Future<List<QuizQuestionModel>> getQuestions(String skillId) async {
    try {
      final res = await dio.dio.get(
        ApiEndpoints.quiz,
        queryParameters: {"skillId": skillId},
      );

      return (res.data as List)
          .map((e) => QuizQuestionModel.fromJson(e))
          .toList();
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException();
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw UnknownException();
    }
  }

  Future<QuizResultModel> submitQuiz({
    required String skillId,
    required Map<String, String> answers,
  }) async {
    try {
      final res = await dio.dio.post(
        ApiEndpoints.submitQuiz,
        data: {"skill_id": skillId, "answers": answers},
      );

      return QuizResultModel.fromJson(res.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException();
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw UnknownException();
    }
  }
}
