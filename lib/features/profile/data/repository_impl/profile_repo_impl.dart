import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/profile/data/datasources/profile_api.dart';
import 'package:skill_issue/features/profile/domain/entities/profile.dart';
import 'package:skill_issue/features/profile/domain/repository/profile_repo.dart';

class ProfileRepoImpl implements ProfileRepository {
  final ProfileApi api;

  ProfileRepoImpl(this.api);

  @override
  Future<Either<Failure, Profile>> getProfile() async {
    try {
      final response = await api.getProfile();

      return Right(response);
    } on NetworkException {
      return const Left(NetworkFailure("No internet connection"));
    } on InvalidCredentialsException {
      return const Left(ServerFailure("Invalid credentials"));
    } on CacheException {
      return const Left(CacheFailure("Failed to save token"));
    } catch (_) {
      return const Left(UnknownFailure("Unexpected error"));
    }
  }

  @override
  Future<Either<Failure, Profile>> updateProfile({required String name}) async {
    try {
      final response = await api.updateProfile(name: name);

      return Right(response);
    } on NetworkException {
      return const Left(NetworkFailure("No internet connection"));
    } on InvalidCredentialsException {
      return const Left(ServerFailure("Invalid credentials"));
    } on CacheException {
      return const Left(CacheFailure("Failed to save token"));
    } catch (_) {
      return const Left(UnknownFailure("Unexpected error"));
    }
  }
}
