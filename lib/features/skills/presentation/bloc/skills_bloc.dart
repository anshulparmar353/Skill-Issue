import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/core/analytics/analytics_service.dart';
import 'package:skill_issue/features/skills/domain/usecases/add_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/delete_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/get_skills_usecase.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_event.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_state.dart';

class SkillsBloc extends Bloc<SkillsEvent, SkillsState> {
  final GetSkillsUseCase getSkills;
  final AddSkillUseCase addSkill;
  final DeleteSkillUseCase deleteSkill;
  final AnalyticsService analytics;

  SkillsBloc(this.getSkills, this.addSkill, this.deleteSkill, this.analytics)
    : super(SkillsInitial()) {
    on<LoadSkills>(_load);
    on<AddSkill>(_add);
    on<DeleteSkill>(_delete);
  }

  Future<void> _load(LoadSkills event, Emitter<SkillsState> emit) async {
    emit(SkillsLoading());

    final result = await getSkills();

    result.fold(
      (failure) => emit(SkillsError(failure.message)),
      (skills) => emit(SkillsLoaded(skills)),
    );
  }

  Future<void> _add(AddSkill event, Emitter<SkillsState> emit) async {
    final result = await addSkill(name: event.skillName);

    result.fold((failure) => emit(SkillsError(failure.message)), (_) {
      analytics.trackSkillAdded(event.skillName);
      add(LoadSkills());
    });
  }

  Future<void> _delete(DeleteSkill event, Emitter<SkillsState> emit) async {
    final result = await deleteSkill(event.skillId);

    result.fold(
      (failure) => emit(SkillsError(failure.message)),
      (_) => add(LoadSkills()),
    );
  }
}
