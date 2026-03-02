import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_issue/features/roadmap/domain/entities/roadmap_step.dart';

import 'package:skill_issue/features/roadmap/presentation/bloc/roadmap_bloc.dart';
import 'package:skill_issue/features/roadmap/presentation/bloc/roadmap_event.dart';
import 'package:skill_issue/features/roadmap/presentation/bloc/roadmap_state.dart';
import 'package:skill_issue/features/roadmap/domain/usecases/get_roadmap_usecase.dart';
import 'package:skill_issue/features/roadmap/domain/entities/roadmap.dart';

class MockGetRoadmapUseCase extends Mock implements GetRoadmapUseCase {}

void main() {
  late RoadmapBloc bloc;
  late MockGetRoadmapUseCase mockUseCase;

  setUp(() {
    mockUseCase = MockGetRoadmapUseCase();
    bloc = RoadmapBloc(mockUseCase);
  });

  final tRoadmap = Roadmap(
    role: "App Dev",
    steps: [
      RoadmapStep(id: '1', title: 'Learn Dart', completed: true),
      RoadmapStep(id: '2', title: 'Learn Flutter', completed: true),
    ],
    completion: 40,
  );

  // -------------------------------------------------
  // SUCCESS CASE
  // -------------------------------------------------

  blocTest<RoadmapBloc, RoadmapState>(
    'emits loading then loaded when roadmap loads successfully',
    build: () {
      when(() => mockUseCase()).thenAnswer((_) async => tRoadmap);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRoadmap()),
    expect: () => [
      RoadmapState.initial().copyWith(loading: true),
      RoadmapState.initial().copyWith(loading: false, roadmap: tRoadmap),
    ],
  );

  // -------------------------------------------------
  // FAILURE CASE
  // -------------------------------------------------

  blocTest<RoadmapBloc, RoadmapState>(
    'emits loading then error when roadmap fails',
    build: () {
      when(() => mockUseCase()).thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRoadmap()),
    expect: () => [
      RoadmapState.initial().copyWith(loading: true),
      RoadmapState.initial().copyWith(
        loading: false,
        error: "Failed to load roadmap",
      ),
    ],
  );

  blocTest<RoadmapBloc, RoadmapState>(
    'emits error when getRoadmap throws',
    build: () {
      when(() => mockUseCase()).thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRoadmap()),
    expect: () => [
      RoadmapState.initial().copyWith(loading: true, error: null),
      RoadmapState.initial().copyWith(
        loading: false,
        error: "Failed to load roadmap",
      ),
    ],
  );
  
}
