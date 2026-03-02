import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_issue/features/auth/data/models/auth_result.dart';

import 'package:skill_issue/features/auth/domain/usecases/login_usecase.dart';
import 'package:skill_issue/features/auth/domain/entities/user.dart';
import 'package:skill_issue/features/auth/domain/repository/auth_repo.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  late LoginUseCase usecase;
  late MockAuthRepository mockRepo;

  setUp(() {
    mockRepo = MockAuthRepository();
    usecase = LoginUseCase(mockRepo);
  });

  final tUser = User(id: '1', email: 'test@gmail.com', name: 'Anshul');

  final tAuthResult = AuthResult(user: tUser, isNewUser: false);

  test('should call repo.login and return AuthResult', () async {
    // Arrange
    when(
      () => mockRepo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => Right(tAuthResult));

    // Act
    final result = await usecase('test@gmail.com', '123456');

    // Assert

    expect(result.isRight(), true);

    result.fold(
      (_) => fail('Expected Right'),
      (authResult) => expect(authResult, tAuthResult),
    );

    verify(
      () => mockRepo.login(email: 'test@gmail.com', password: '123456'),
    ).called(1);

    verifyNoMoreInteractions(mockRepo);
  });

  test('should throw exception when repo throws exception', () async {
    // Arrange
    when(
      () => mockRepo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenThrow(Exception('Invalid credentials'));

    // Act & Assert
    expect(
      () => usecase('wrong@gmail.com', 'wrongpass'),
      throwsA(isA<Exception>()),
    );

    verify(
      () => mockRepo.login(email: 'wrong@gmail.com', password: 'wrongpass'),
    ).called(1);
  });
}
