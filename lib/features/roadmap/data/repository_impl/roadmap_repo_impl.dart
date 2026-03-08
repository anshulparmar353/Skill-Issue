import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/core/network/network_info.dart';
import 'package:skill_issue/features/roadmap/data/datasources/roadmap_api.dart';
import 'package:skill_issue/features/roadmap/domain/entities/roadmap.dart';
import 'package:skill_issue/features/roadmap/domain/repository/roadmap_repo.dart';


class RoadmapRepoImpl implements RoadmapRepository {
  final RoadmapApi api;
  final NetworkInfo networkInfo;

  RoadmapRepoImpl(this.api, this.networkInfo);

  @override
  Future<Either<Failure, Roadmap>> getRoadmap(String roleId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure("No internet connection"));
    }

    try {
      final roadmap = await api.getRoadmap(roleId);

      return Right(roadmap);
    }  on ServerException {
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
