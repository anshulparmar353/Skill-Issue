import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/core/network/network_info.dart';
import 'package:skill_issue/features/dashboard/data/datasources/dashboard_api.dart';
import 'package:skill_issue/features/dashboard/domain/repository/dashboard_repo.dart';
import '../../domain/entities/dashboard_data.dart';

class DashboardRepoImpl implements DashboardRepository {
  final DashboardApi api;
  final NetworkInfo networkInfo;

  DashboardRepoImpl(this.api, this.networkInfo);

  @override
  Future<Either<Failure, DashboardData>> getDashboardData() async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure("No internet connection"));
    }

    try {
      final result = await api.getDashboardSummary();
      return Right(result);
    } on ServerException {
      return const Left(ServerFailure("Server error"));
    } on NetworkException {
      return const Left(NetworkFailure("No internet connection"));
    } catch (_) {
      return const Left(UnknownFailure("Unexpected error"));
    }
  }
}
