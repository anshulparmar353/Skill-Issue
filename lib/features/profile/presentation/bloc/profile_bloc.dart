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

    final profile = await getProfile();

    emit(ProfileState(
      loading: false,
      profile: profile,
    ));
  }

  Future<void> _update(UpdateProfileName event, emit) async {

    emit(ProfileState(loading: true));

    final profile = await updateProfile(name: event.name);

    emit(ProfileState(
      loading: false,
      profile: profile,
      updated: true,
    ));
  }
}
