import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:skill_issue/features/profile/presentation/bloc/profile_bloc.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_event.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_state.dart';
import 'package:skill_issue/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:skill_issue/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:skill_issue/features/profile/domain/entities/profile.dart';

class MockGetProfileUseCase extends Mock implements GetProfileUseCase {}
class MockUpdateProfileUseCase extends Mock implements UpdateProfileUseCase {}

void main() {
  late ProfileBloc bloc;
  late MockGetProfileUseCase mockGet;
  late MockUpdateProfileUseCase mockUpdate;

  setUp(() {
    mockGet = MockGetProfileUseCase();
    mockUpdate = MockUpdateProfileUseCase();
    bloc = ProfileBloc(mockGet, mockUpdate);
  });

  final tProfile = Profile(
    id: '1',
    name: 'Anshul',
    email: 'test@gmail.com',
  );

  // -------------------------------------------------
  // LOAD PROFILE SUCCESS
  // -------------------------------------------------

  blocTest<ProfileBloc, ProfileState>(
    'emits loading then loaded when profile loads',
    build: () {
      when(() => mockGet()).thenAnswer((_) async => tProfile);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadProfile()),
    expect: () => [
      ProfileState(loading: true),
      ProfileState(
        loading: false,
        profile: tProfile,
      ),
    ],
  );

  // -------------------------------------------------
  // UPDATE PROFILE SUCCESS
  // -------------------------------------------------

  blocTest<ProfileBloc, ProfileState>(
    'emits loading then updated state when profile name updated',
    build: () {
      when(() => mockUpdate(name: any(named: 'name')))
          .thenAnswer((_) async => tProfile);
      return bloc;
    },
    act: (bloc) => bloc.add(UpdateProfileName('New Name')),
    expect: () => [
      ProfileState(loading: true),
      ProfileState(
        loading: false,
        profile: tProfile,
        updated: true,
      ),
    ],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits error when getProfile throws',
    build: () {
      when(() => mockGet()).thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(LoadProfile()),
    expect: () => [
      ProfileState.initial().copyWith(loading: true, error: null),
      ProfileState.initial().copyWith(
        loading: false,
        error: "Failed to load profile",
      ),
    ],
  );

  blocTest<ProfileBloc, ProfileState>(
    'emits error when updateProfile throws',
    build: () {
      when(() => mockUpdate(name: any(named: 'name')))
          .thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(UpdateProfileName('New Name')),
    expect: () => [
      ProfileState.initial().copyWith(
        loading: true,
        error: null,
        updated: false,
      ),
      ProfileState.initial().copyWith(
        loading: false,
        error: "Failed to update profile",
      ),
    ],
  );

}