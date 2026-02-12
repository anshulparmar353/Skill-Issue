import 'package:skill_issue/features/auth/data/models/auth_result.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

class GetCurrentUserUseCase {

  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  Future<AuthResult> call() {
    return repository.getCurrentUser();
  }
}
