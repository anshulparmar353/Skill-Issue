import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:skill_issue/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_event.dart';
import 'package:skill_issue/features/profile/presentation/bloc/profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  final GetProfileUseCase getProfile;
  final UpdateProfileUseCase updateProfile;

  ProfileBloc(this.getProfile, this.updateProfile) : super(ProfileInitial()) {
    on<LoadProfile>(_load);
    on<UpdateProfileName>(_update);
  }

  Future<void> _load(LoadProfile event, emit) async {
    emit(ProfileLoading());

    try {
      final result = await getProfile();

      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (profile) => emit(ProfileLoaded(profile)),
      );
    } catch (e) {
      emit(ProfileError("Failed to load profile"));
    }
  }

  Future<void> _update(UpdateProfileName event, emit) async {
    emit(ProfileLoading());

    try {
      final result = await updateProfile(name: event.name);

      result.fold(
        (failure) => emit(ProfileError(failure.message)),
        (update) => emit(ProfileUpdate(update)),
      );
    } catch (e) {
      emit(ProfileError("Failed to update profile"));
    }
  }
}
