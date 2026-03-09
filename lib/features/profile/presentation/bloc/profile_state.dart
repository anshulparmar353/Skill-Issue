import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/profile/domain/entities/profile.dart';

abstract class ProfileState with EquatableMixin {
  @override
  List<Object?> get props => [];
}

class ProfileInitial extends ProfileState {}

class ProfileLoading extends ProfileState {}

class ProfileLoaded extends ProfileState {
  final Profile profile;

  ProfileLoaded(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileUpdate extends ProfileState {
  final Profile profile;

  ProfileUpdate(this.profile);

  @override
  List<Object?> get props => [profile];
}

class ProfileError extends ProfileState {
  final String message;

  ProfileError(this.message);

  @override
  List<Object?> get props => [message];
}
