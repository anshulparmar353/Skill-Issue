import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:skill_issue/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_event.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {

  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;

  ProfileBloc(this.getProfile, this.updateProfile)
      : super(ProfileState.initial()) {

    on<LoadProfile>(_load);
    on<UpdateProfileName>(_update);
  }

  Future<void> _load(LoadProfile event, emit) async {

    emit(ProfileState(loading: true));

    try {
      final profile = await getProfile();
      emit(state.copyWith(
        loading: false,
        profile: profile,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: "Failed to load profile",
      ));
    }
  }

  Future<void> _update(UpdateProfileName event, emit) async {

    emit(ProfileState(loading: true));

    try {
      final profile = await updateProfile(name: event.name);
      emit(state.copyWith(
        loading: false,
        profile: profile,
        updated: true,
      ));
    } catch (e) {
      emit(state.copyWith(
        loading: false,
        error: "Failed to update profile",
      ));
    }
  }
}
