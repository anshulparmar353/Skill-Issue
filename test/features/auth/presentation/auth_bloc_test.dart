import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/auth/data/models/user_model.dart';

import 'package:skill_issue/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_event.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_state.dart';
import 'package:skill_issue/features/auth/domain/usecases/login_usecase.dart';
import 'package:skill_issue/features/auth/domain/usecases/et_current_user_usecase.dart';
import 'package:skill_issue/features/auth/data/models/auth_result.dart';

class MockLoginUseCase extends Mock implements LoginUseCase {}

class MockGetCurrentUserUseCase extends Mock implements GetCurrentUserUseCase {}

void main() {
  late AuthBloc bloc;
  late MockLoginUseCase mockLoginUseCase;
  late MockGetCurrentUserUseCase mockGetCurrentUserUseCase;

  setUp(() {
    mockLoginUseCase = MockLoginUseCase();
    mockGetCurrentUserUseCase = MockGetCurrentUserUseCase();
    bloc = AuthBloc(mockLoginUseCase, mockGetCurrentUserUseCase);
  });

  final tUser = UserModel(id: '1', email: 'test@gmail.com', name: "anshul");

  final tAuthResult = AuthResult(user: tUser, isNewUser: false);

  // -------------------------------------------------
  // LOGIN SUCCESS
  // -------------------------------------------------

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, Authenticated] when login succeeds',
    build: () {
      when(
        () => mockLoginUseCase(any(), any()),
      ).thenAnswer((_) async => Right(tAuthResult));
      return bloc;
    },
    act: (bloc) => bloc.add(LoginRequested('test@gmail.com', '123456')),
    expect: () => [AuthLoading(), Authenticated(user: tUser, isNewUser: false)],
  );

  // -------------------------------------------------
  // LOGIN FAILURE
  // -------------------------------------------------

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, AuthError] when login throws',
    build: () {
      when(() => mockLoginUseCase(any(), any())).thenAnswer(
        (_) async => const Left(NetworkFailure("No internet connection")),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoginRequested('x', 'y')),
    expect: () => [AuthLoading(), AuthError(message: "No internet connection")],
  );

  // -------------------------------------------------
  // LOGOUT
  // -------------------------------------------------

  blocTest<AuthBloc, AuthState>(
    'emits [Unauthenticated] when logout requested',
    build: () => bloc,
    act: (bloc) => bloc.add(LogoutRequested()),
    expect: () => [Unauthenticated()],
  );

  // -------------------------------------------------
  // CHECK AUTH SUCCESS
  // -------------------------------------------------

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, Authenticated] when check auth succeeds',
    build: () {
      when(
        () => mockGetCurrentUserUseCase(),
      ).thenAnswer((_) async => Right(tAuthResult));
      return bloc;
    },
    act: (bloc) => bloc.add(CheckAuthStatus()),
    expect: () => [AuthLoading(), Authenticated(user: tUser, isNewUser: false)],
  );

  // -------------------------------------------------
  // CHECK AUTH FAILURE
  // -------------------------------------------------

  blocTest<AuthBloc, AuthState>(
    'emits [AuthLoading, Unauthenticated] when check auth fails',
    build: () {
      when(() => mockGetCurrentUserUseCase()).thenAnswer(
        (_) async => const Left(NetworkFailure("No internet connection")),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(CheckAuthStatus()),
    expect: () => [AuthLoading(), Unauthenticated()],
  );
}
