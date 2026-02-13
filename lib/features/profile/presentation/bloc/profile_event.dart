abstract class ProfileEvent {}

class LoadProfile extends ProfileEvent {}

class UpdateProfileName extends ProfileEvent {
  final String name;

  UpdateProfileName(this.name);
}

class LogoutRequested extends ProfileEvent {}
