import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/add_skills/domain/usecases/get_skills_usecase.dart';
import 'package:skill_issue/features/add_skills/domain/usecases/submit_user_skills_usecase.dart';
import 'package:skill_issue/features/add_skills/presentation/bloc/skills_event.dart';
import 'package:skill_issue/features/add_skills/presentation/bloc/skills_state.dart';

class SkillsOnboardingBloc extends Bloc<SkillsOnboardingEvent, SkillsOnboardingState> {

  final GetAvailableSkillsUseCase getSkills;
  final SubmitUserSkillsUseCase submitSkills;

  SkillsOnboardingBloc(this.getSkills, this.submitSkills)
      : super(SkillsOnboardingState.initial()) {

    on<LoadAvailableSkills>(_load);
    on<ToggleSkillSelection>(_toggle);
    on<SubmitSelectedSkills>(_submit);
  }

  Future<void> _load(LoadAvailableSkills load,Emitter emit) async {

    emit(state.copyWith(loading: true));

    final skills = await getSkills();

    emit(state.copyWith(
      skills: skills,
      loading: false,
    ));
  }

  void _toggle(ToggleSkillSelection event,Emitter emit) {

    final updated = Set<String>.from(state.selectedIds);

    if (updated.contains(event.skillId)) {
      updated.remove(event.skillId);
    } else {
      updated.add(event.skillId);
    }

    emit(state.copyWith(selectedIds: updated));
  }

  Future<void> _submit(SubmitSelectedSkills event,Emitter emit) async {

    emit(state.copyWith(loading: true));

    await submitSkills(state.selectedIds.toList());

    emit(state.copyWith(
      loading: false,
      submitted: true,
    ));
  }
}
