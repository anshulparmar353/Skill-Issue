import 'package:skill_issue/core/network/dio_client.dart';
import 'package:skill_issue/features/quiz/data/models/quiz_question_model.dart';
import 'package:skill_issue/features/quiz/data/models/quiz_result_model.dart';

class QuizApi {

  final DioClient dio;

  QuizApi(this.dio);

  Future<List<QuizQuestionModel>> getQuestions(
      String skillId) async {

    final res = await dio.dio.get("/quiz/$skillId");

    return (res.data as List)
        .map((e) => QuizQuestionModel.fromJson(e))
        .toList();
  }

  Future<QuizResultModel> submitQuiz({
    required String skillId,
    required Map<String, String> answers,
  }) async {

    final res = await dio.dio.post(
      "/quiz/submit",
      data: {
        "skill_id": skillId,
        "answers": answers,
      },
    );

    return QuizResultModel.fromJson(res.data);
  }
}
