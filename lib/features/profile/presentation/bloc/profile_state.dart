import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/profile/domain/entities/profile.dart';

class ProfileState extends Equatable {

  final bool loading;
  final Profile? profile;
  final bool updated;
  final String? error;

  const ProfileState({
    required this.loading,
    this.profile,
    this.updated = false,
    this.error
  });

  factory ProfileState.initial() => ProfileState(loading: false);

  ProfileState copyWith({
    bool? loading,
    Profile? profile,
    bool? updated,
    String? error,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
      updated: updated ?? this.updated,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, profile, updated];
}
