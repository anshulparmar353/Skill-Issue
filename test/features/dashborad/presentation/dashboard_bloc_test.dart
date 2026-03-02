import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_state.dart';
import 'package:skill_issue/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:skill_issue/features/dashboard/domain/entities/dashboard_data.dart';

class MockGetDashboardUseCase extends Mock
    implements GetDashboardDataUseCase {}

void main() {
  late DashboardBloc bloc;
  late MockGetDashboardUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetDashboardUseCase();
    bloc = DashboardBloc(mockUseCase);
  });

  final tDashboardData = DashboardData(
    totalSkills: 10,
    beginner: 3,
    intermediate: 4,
    advanced: 3,
    roadmapCompletion: 60,
  );

  // -------------------------------------------------
  // SUCCESS
  // -------------------------------------------------

  blocTest<DashboardBloc, DashboardState>(
    'emits loading then loaded when dashboard loads successfully',
    build: () {
      when(() => mockUseCase())
          .thenAnswer((_) async => tDashboardData);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadDashboard()),
    expect: () => [
      DashboardState(loading: true),
      DashboardState(
        loading: false,
        data: tDashboardData,
      ),
    ],
  );

  // -------------------------------------------------
  // FAILURE
  // -------------------------------------------------

  blocTest<DashboardBloc, DashboardState>(
    'emits loading then error when dashboard fails',
    build: () {
      when(() => mockUseCase())
          .thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(LoadDashboard()),
    expect: () => [
      DashboardState(loading: true),
      DashboardState(
        loading: false,
        error: "Failed to load dashboard",
      ),
    ],
  );

  blocTest<DashboardBloc, DashboardState>(
    'emits error when getDashboard throws',
    build: () {
      when(() => mockUseCase()).thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(LoadDashboard()),
    expect: () => [
      DashboardState.initial().copyWith(loading: true, error: null),
      DashboardState.initial().copyWith(
        loading: false,
        error: "Failed to load dashboard",
      ),
    ],
  );
}