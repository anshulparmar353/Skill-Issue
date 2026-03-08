import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/skills/data/datasources/skills_api.dart';
import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';
import 'package:skill_issue/features/skills/data/datasources/skills_local_datasource.dart';

import '../../../../core/network/network_info.dart';
import '../../domain/entities/skill.dart';

class SkillsRepoImpl implements SkillsRepository {
  final SkillsApi api;
  final SkillsLocalDataSource local;
  final NetworkInfo networkInfo;

  SkillsRepoImpl(this.api, this.local, this.networkInfo);

  @override
  Future<Either<Failure, List<Skill>>> getSkills() async {
    if (await networkInfo.isConnected) {
      try {
        final resultSkills = await api.getSkills();

        await local.cacheSkills(resultSkills);

        return Right(resultSkills);
      } on ServerException {
        return const Left(ServerFailure("Server error"));
      } on NetworkException {
        return const Left(NetworkFailure("No internet connection"));
      } catch (_) {
        return const Left(UnknownFailure("Unexpected error"));
      }
    }

    try {
      final cachedSkills = await local.getCachedSkills();

      return Right(cachedSkills);
    } on CacheException {
      return const Left(CacheFailure("No cached skills found"));
    }
  }

  @override
  Future<Either<Failure, Unit>> addSkill({required String name}) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure("No internet connection"));
    }
    try {
      await api.addSkill(name: name);
      return Right(unit);
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
  Future<Either<Failure, Unit>> deleteSkill(String skillId) async {
    if (!await networkInfo.isConnected) {
      return const Left(NetworkFailure("No internet connection"));
    }

    try {
      await api.deleteSkill(skillId);
      return Right(unit);
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
