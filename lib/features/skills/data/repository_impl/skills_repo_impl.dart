import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/skills/data/datasources/skills_api.dart';
import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';
import '../../domain/entities/skill.dart';

class SkillsRepoImpl implements SkillsRepository {
  final SkillsApi api;

  SkillsRepoImpl(this.api);

  @override
  Future<Either<Failure, List<Skill>>> getSkills() async {
    try {
      final skills = await api.getSkills();
      return Right(skills);
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
  Future<Either<Failure, Unit>> addSkill({required String name}) async {
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
