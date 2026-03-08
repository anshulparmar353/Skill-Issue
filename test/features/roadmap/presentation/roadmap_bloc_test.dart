import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_issue/core/errors/failures.dart';
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
      RoadmapStep(title: 'Learn Dart', description: "dart", completed: true),
      RoadmapStep(
        title: 'Learn Flutter',
        description: "flutter",
        completed: true,
      ),
    ],
    completion: 40,
  );

  // -------------------------------------------------
  // SUCCESS CASE
  // -------------------------------------------------

  blocTest<RoadmapBloc, RoadmapState>(
    'emits loading then loaded when roadmap loads successfully',
    build: () {
      when(
        () => mockUseCase("flutter"),
      ).thenAnswer((_) async => Right(tRoadmap));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRoadmap("flutter")),
    expect: () => [RoadmapLoading(), RoadmapLoaded(tRoadmap)],
  );

  // -------------------------------------------------
  // FAILURE CASE
  // -------------------------------------------------

  blocTest<RoadmapBloc, RoadmapState>(
    'emits loading then error when roadmap fails',
    build: () {
      when(() => mockUseCase("flutter")).thenAnswer(
        (_) async => const Left(ServerFailure("Failed to load Roadmap")),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRoadmap("flutter")),
    expect: () => [RoadmapLoading(), RoadmapError("Failed to load Roadmap")],
  );

  blocTest<RoadmapBloc, RoadmapState>(
    'emits error when getRoadmap throws',
    build: () {
      when(() => mockUseCase("flutter")).thenAnswer(
        (_) async => const Left(ServerFailure("Failed to load Roadmap")),
      );
      return bloc;
    },
    act: (bloc) => bloc.add(LoadRoadmap("flutter")),
    expect: () => [RoadmapLoading(), RoadmapError("Failed to load Roadmap")],
  );
}
