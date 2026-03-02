import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_issue/core/errors/failures.dart';

import 'package:skill_issue/features/auth/data/datasources/auth_api.dart';
import 'package:skill_issue/features/auth/data/datasources/user_api.dart';
import 'package:skill_issue/features/auth/data/datasources/register_api.dart';
import 'package:skill_issue/core/storage/token_storage.dart';
import 'package:skill_issue/features/auth/data/models/auth_response_model.dart';
import 'package:skill_issue/features/auth/data/models/user_model.dart';
import 'package:skill_issue/features/auth/data/repository_impl/auth_repo_impl.dart';

class MockAuthApi extends Mock implements AuthApi {}

class MockUserApi extends Mock implements UserApi {}

class MockRegisterApi extends Mock implements RegisterApi {}

class MockTokenStorage extends Mock implements TokenStorage {}

void main() {
  late AuthRepoImpl repo;
  late MockAuthApi mockApi;
  late MockUserApi mockUserApi;
  late MockRegisterApi mockRegisterApi;
  late MockTokenStorage mockTokenStorage;

  setUp(() {
    mockApi = MockAuthApi();
    mockUserApi = MockUserApi();
    mockRegisterApi = MockRegisterApi();
    mockTokenStorage = MockTokenStorage();

    repo = AuthRepoImpl(
      mockApi,
      mockUserApi,
      mockRegisterApi,
      mockTokenStorage,
    );
  });

  final tUser = UserModel(id: '1', email: 'test@gmail.com', name: "anshul");

  test('login should call api and save tokens', () async {
    final fakeApiResponse = AuthResponseModel(
      accessToken: 'access123',
      refreshToken: 'refresh123',
      user: tUser,
      isNewUser: false,
    );

    when(
      () => mockApi.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => fakeApiResponse);

    when(
      () => mockTokenStorage.saveTokens(
        access: any(named: 'access'),
        refresh: any(named: 'refresh'),
      ),
    ).thenAnswer((_) async {});

    final result = await repo.login(
      email: 'test@gmail.com',
      password: '123456',
    );

    expect(result.isRight(), true);

    result.fold((_) => fail('Expected Right'), (authResult) {
      expect(authResult.user, tUser);
      expect(authResult.isNewUser, false);
    });

    verify(
      () => mockApi.login(email: 'test@gmail.com', password: '123456'),
    ).called(1);

    verify(
      () => mockTokenStorage.saveTokens(
        access: 'access123',
        refresh: 'refresh123',
      ),
    ).called(1);
  });

  test('login should throw when api fails', () async {
    when(
      () => mockApi.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception('Login failed'));

    final result = await repo.login(email: 'x', password: 'y');

    expect(result.isLeft(), true);

    result.fold(
      (failure) => expect(failure, isA<UnknownFailure>()),
      (_) => fail('Expected Left'),
    );

    verify(() => mockApi.login(email: 'x', password: 'y')).called(1);

    verifyNever(
      () => mockTokenStorage.saveTokens(
        access: any(named: 'access'),
        refresh: any(named: 'refresh'),
      ),
    );
  });
}
