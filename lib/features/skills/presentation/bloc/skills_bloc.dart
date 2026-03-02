import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/skills/domain/usecases/add_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/delete_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/get_skills_usecase.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_event.dart';
import 'package:skill_issue/features/skills/presentation/bloc/skills_state.dart';

class SkillsBloc extends Bloc<SkillsEvent, SkillsState> {
  final GetSkillsUseCase getSkills;
  final AddSkillUseCase addSkill;
  final DeleteSkillUseCase deleteSkill;

  SkillsBloc(this.getSkills, this.addSkill, this.deleteSkill)
    : super(SkillsState.initial()) {
    on<LoadSkills>(_load);
    on<AddSkill>(_add);
    on<DeleteSkill>(_delete);
  }

  Future<void> _load(LoadSkills event, emit) async {
    emit(state.copyWith(loading: true, error: null));

    try {
      final skills = await getSkills();

      emit(state.copyWith(
        loading: false,
        skills: skills,
      ));

    } catch (e) {
      emit(state.copyWith(
        loading: false, 
        error: "Failed to load skills",
      ));
    }
  }

  Future<void> _add(AddSkill event, emit) async {

    try {
      await addSkill(name: event.skillName);
      add(LoadSkills());

    } catch (e) {
      emit(state.copyWith(
        error: "Failed to add skill",
      ));
    }
  }

  Future<void> _delete(DeleteSkill event, emit) async {
    
    try {
      await deleteSkill(event.skillId);
      add(LoadSkills());
    } catch (e) {
      emit(state.copyWith(
        error: "Failed to delete skill",
      ));
    }
  }
  
}
