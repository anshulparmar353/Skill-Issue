import 'package:skill_issue/features/profile/domain/entities/profile.dart';

class ProfileState {

  final bool loading;
  final Profile? profile;
  final bool updated;

  ProfileState({
    required this.loading,
    this.profile,
    this.updated = false,
  });

  factory ProfileState.initial() => ProfileState(loading: false);
}
