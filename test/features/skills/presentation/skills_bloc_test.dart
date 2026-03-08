import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:skill_issue/core/analytics/analytics_service.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/add_skills/domain/entities/skill_level.dart';

import 'package:skill_issue/features/skills/presentation/bloc/skills_bloc.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_event.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_state.dart';
import 'package:skill_issue/features/skills/domain/usecases/get_skills_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/add_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/delete_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/entities/skill.dart';

class MockGetSkillsUseCase extends Mock implements GetSkillsUseCase {}

class MockAddSkillUseCase extends Mock implements AddSkillUseCase {}

class MockDeleteSkillUseCase extends Mock implements DeleteSkillUseCase {}

class MockAnalyticsService extends Mock implements AnalyticsService {}

void main() {
  late SkillsBloc bloc;
  late MockGetSkillsUseCase mockGet;
  late MockAddSkillUseCase mockAdd;
  late MockDeleteSkillUseCase mockDelete;
  late MockAnalyticsService mockAnalytics;

  setUp(() {
    mockGet = MockGetSkillsUseCase();
    mockAdd = MockAddSkillUseCase();
    mockDelete = MockDeleteSkillUseCase();
    mockAnalytics = MockAnalyticsService();

    bloc = SkillsBloc(mockGet, mockAdd, mockDelete, mockAnalytics);
  });

  final tSkills = [
    Skill(id: '1', name: 'Flutter', level: SkillLevel.beginner),
    Skill(id: '2', name: 'DSA', level: SkillLevel.intermediate),
  ];

  // -------------------------------------------------
  // LOAD SUCCESS
  // -------------------------------------------------

  blocTest<SkillsBloc, SkillsState>(
    'emits [Loading, Loaded] when skills load successfully',
    build: () {
      when(() => mockGet()).thenAnswer((_) async => Right(tSkills));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadSkills()),
    expect: () => [isA<SkillsLoading>(), isA<SkillsLoaded>()],
  );

  // -------------------------------------------------
  // ADD SKILL (should trigger reload)
  // -------------------------------------------------

  blocTest<SkillsBloc, SkillsState>(
    'add skill triggers reload',
    build: () {
      when(
        () => mockAdd(name: any(named: 'name')),
      ).thenAnswer((_) async => Right(unit));
      when(() => mockGet()).thenAnswer((_) async => Right(tSkills));
      return bloc;
    },
    act: (bloc) => bloc.add(AddSkill('Flutter')),
    expect: () => [isA<SkillsLoading>(), isA<SkillsLoaded>()],
  );

  // -------------------------------------------------
  // DELETE SKILL (should trigger reload)
  // -------------------------------------------------

  blocTest<SkillsBloc, SkillsState>(
    'delete skill triggers reload',
    build: () {
      when(() => mockDelete(any())).thenAnswer((_) async => Right(unit));
      when(() => mockGet()).thenAnswer((_) async => Right(tSkills));
      return bloc;
    },
    act: (bloc) => bloc.add(DeleteSkill('1')),
    expect: () => [isA<SkillsLoading>(), isA<SkillsLoaded>()],
  );

  // -------------------------------------------------
  // ERROR CASE
  // -------------------------------------------------

  blocTest<SkillsBloc, SkillsState>(
    'emits [Loading, Error] when getSkills fails',
    build: () {
      when(
        () => mockGet(),
      ).thenAnswer((_) async => Left(ServerFailure("error")));
      return bloc;
    },
    act: (bloc) => bloc.add(LoadSkills()),
    expect: () => [isA<SkillsLoading>(), isA<SkillsError>()],
  );
}
