import 'package:flutter_test/flutter_test.dart';
import 'package:bloc_test/bloc_test.dart';
import 'package:mocktail/mocktail.dart';
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

void main() {
  late SkillsBloc bloc;
  late MockGetSkillsUseCase mockGet;
  late MockAddSkillUseCase mockAdd;
  late MockDeleteSkillUseCase mockDelete;

  setUp(() {
    mockGet = MockGetSkillsUseCase();
    mockAdd = MockAddSkillUseCase();
    mockDelete = MockDeleteSkillUseCase();

    bloc = SkillsBloc(mockGet, mockAdd, mockDelete);
  });

  final tSkills = [
    Skill(id: '1', name: 'Flutter', level: SkillLevel.beginner),
    Skill(id: '2', name: 'DSA', level: SkillLevel.intermediate),
  ];

  // -------------------------------------------------
  // LOAD SUCCESS
  // -------------------------------------------------

  blocTest<SkillsBloc, SkillsState>(
    'emits loading then loaded when skills load successfully',
    build: () {
      when(() => mockGet()).thenAnswer((_) async => tSkills);
      return bloc;
    },
    act: (bloc) => bloc.add(LoadSkills()),
    expect: () => [
      SkillsState.initial().copyWith(loading: true),
      SkillsState.initial().copyWith(loading: false, skills: tSkills),
    ],
  );

  // -------------------------------------------------
  // ADD SKILL (should trigger reload)
  // -------------------------------------------------

  blocTest<SkillsBloc, SkillsState>(
    'add skill triggers reload',
    build: () {
      when(() => mockAdd(name: any(named: 'name'))).thenAnswer((_) async {});
      when(() => mockGet()).thenAnswer((_) async => tSkills);
      return bloc;
    },
    act: (bloc) => bloc.add(AddSkill('Flutter')),
    expect: () => [
      SkillsState.initial().copyWith(loading: true),
      SkillsState.initial().copyWith(loading: false, skills: tSkills),
    ],
  );

  // -------------------------------------------------
  // DELETE SKILL (should trigger reload)
  // -------------------------------------------------

  blocTest<SkillsBloc, SkillsState>(
    'delete skill triggers reload',
    build: () {
      when(() => mockDelete(any())).thenAnswer((_) async {});
      when(() => mockGet()).thenAnswer((_) async => tSkills);
      return bloc;
    },
    act: (bloc) => bloc.add(DeleteSkill('1')),
    expect: () => [
      SkillsState.initial().copyWith(loading: true),
      SkillsState.initial().copyWith(loading: false, skills: tSkills),
    ],
  );

  blocTest<SkillsBloc, SkillsState>(
    'emits error when getSkills throws',
    build: () {
      when(() => mockGet()).thenThrow(Exception());
      return bloc;
    },
    act: (bloc) => bloc.add(LoadSkills()),
    expect: () => [
      SkillsState.initial().copyWith(loading: true, error: null),
      SkillsState.initial().copyWith(
        loading: false,
        error: "Failed to load skills",
      ),
    ],
  );
}
