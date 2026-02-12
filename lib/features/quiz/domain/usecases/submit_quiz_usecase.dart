import 'package:skill_issue/features/quiz/domain/entities/quiz_result.dart';
import 'package:skill_issue/features/quiz/domain/repository/quiz_repo.dart';

class SubmitQuizUseCase {

  final QuizRepository repo;

  SubmitQuizUseCase(this.repo);

  Future<QuizResult> call({
    required String skillId,
    required Map<String, String> answers,
  }) {
    return repo.submitAnswers(
      skillId: skillId,
      answers: answers,
    );
  }
}
