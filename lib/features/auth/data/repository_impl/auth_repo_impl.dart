import 'dart:async';
import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/auth/data/datasources/auth_api.dart';
import 'package:skill_issue/features/auth/data/datasources/register_api.dart';
import 'package:skill_issue/features/auth/data/datasources/user_api.dart';
import 'package:skill_issue/features/auth/data/models/auth_result.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

import '../../../../core/storage/token_storage.dart';

class AuthRepoImpl implements AuthRepository {
  final AuthApi api;
  final UserApi userApi;
  final TokenStorage tokenStorage;
  final RegisterApi registerApi;

  AuthRepoImpl(this.api, this.userApi, this.registerApi, this.tokenStorage);

  @override
  Future<Either<Failure, AuthResult>> login({
    required String email,
    required String password,
  }) async {
    try {
      final response = await api.login(email: email, password: password);

      await tokenStorage.saveTokens(
        access: response.accessToken,
        refresh: response.refreshToken,
      );

      return Right(
        AuthResult(user: response.user, isNewUser: response.isNewUser),
      );
    } on SocketException {
      return const Left(NetworkFailure("No internet connection"));
    } on TimeoutException {
      return const Left(NetworkFailure("Request timed out"));
    } on SocketDirection catch (e) {
      return Left(ServerFailure(e as String));
    } catch (e) {
      return const Left(UnknownFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> getCurrentUser() async {
    try {
      final result = await userApi.getCurrentUser();

      return Right(AuthResult(user: result.user, isNewUser: result.isNewUser));
    } on SocketException {
      return const Left(NetworkFailure("No internet connection"));
    } on TimeoutException {
      return const Left(NetworkFailure("Request timed out"));
    } on SocketDirection catch (e) {
      return Left(ServerFailure(e as String));
    } catch (e) {
      return const Left(UnknownFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> register({
    required String email,
    required String password,
    required String name,
  }) async {
    try {
      final response = await registerApi.register(
        email: email,
        password: password,
        name: name,
      );

      await tokenStorage.saveTokens(
        access: response.accessToken,
        refresh: response.refreshToken,
      );

      return Right(
        AuthResult(user: response.user, isNewUser: response.isNewUser),
      );
    } on SocketException {
      return const Left(NetworkFailure("No internet connection"));
    } on TimeoutException {
      return const Left(NetworkFailure("Request timed out"));
    } on SocketDirection catch (e) {
      return Left(ServerFailure(e as String));
    } catch (e) {
      return const Left(UnknownFailure("Something went wrong"));
    }
  }

  @override
  Future<Either<Failure, Unit>> logout() async {

    try {
      await tokenStorage.clear();
    } on SocketException {
      return const Left(NetworkFailure("No internet connection"));
    } on TimeoutException {
      return const Left(NetworkFailure("Request timed out"));
    } on SocketDirection catch (e) {
      return Left(ServerFailure(e as String));
    } catch (e) {
      return const Left(UnknownFailure("Something went wrong"));
    }

    throw Exception("Logout Failed");
  }
}
