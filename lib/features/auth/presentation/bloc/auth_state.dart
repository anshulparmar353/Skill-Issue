import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/auth/domain/entities/user.dart';

abstract class AuthState extends Equatable {
  @override
  List<Object?> get props => [];
}

class AuthInitial extends AuthState {}

class AuthLoading extends AuthState {}

class Authenticated extends AuthState {
  final User user;
  final bool isNewUser;

  Authenticated({required this.user, required this.isNewUser});

  @override
  List<Object?> get props => [user,isNewUser];
}

class Unauthenticated extends AuthState {}

class AuthError extends AuthState {
  final String message;

  AuthError({required this.message});

  @override
  List<Object?> get props => [message];
}
