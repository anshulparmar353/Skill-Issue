import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';

class QuizQuestionModel extends QuizQuestion {

  QuizQuestionModel({
    required super.id,
    required super.question,
    required super.options,
  });

   factory QuizQuestionModel.fromJson(Map<String, dynamic> json) {

    return QuizQuestionModel(
      id: json["id"].toString(),

      question: json["question"] ?? "",

      options: (json["options"] as List<dynamic>)
          .map((op) => op.toString())
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "question": question,
      "options": options,
    };
  }
}
