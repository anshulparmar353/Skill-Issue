import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/dashboard/domain/repository/dashboard_repo.dart';
import '../entities/dashboard_data.dart';

class GetDashboardDataUseCase {

  final DashboardRepository repository;

  GetDashboardDataUseCase(this.repository);

  Future<Either<Failure, DashboardData>> call() {
    return repository.getDashboardData();
  }
}
