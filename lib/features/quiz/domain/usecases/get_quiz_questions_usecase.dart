import 'package:skill_issue/features/quiz/domain/entities/quiz_question.dart';
import 'package:skill_issue/features/quiz/domain/repository/quiz_repo.dart';

class GetQuizQuestionsUseCase {

  final QuizRepository repo;

  GetQuizQuestionsUseCase(this.repo);

  Future<List<QuizQuestion>> call(String skillId) {
    return repo.getQuestions(skillId);
  }
}
