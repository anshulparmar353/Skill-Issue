import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/auth/domain/usecases/et_current_user_usecase.dart';
import 'package:skill_issue/features/auth/domain/usecases/login_usecase.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_event.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;
  final GetCurrentUserUseCase getCurrentUserUseCase;

  AuthBloc(this.loginUseCase, this.getCurrentUserUseCase)
    : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
    on<CheckAuthStatus>(_onCheckAuthStatus);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await loginUseCase(event.email, event.password);

    result.fold(
      (failure) => emit(AuthError(message: failure.message)),
      (authResult) => emit(
        Authenticated(user: authResult.user, isNewUser: authResult.isNewUser),
      ),
    );
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
  }

  Future<void> _onCheckAuthStatus(
    CheckAuthStatus event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    final result = await getCurrentUserUseCase();

    result.fold(
      (_) => emit(Unauthenticated()),
      (authResult) => emit(
        Authenticated(user: authResult.user, isNewUser: authResult.isNewUser),
      ),
    );
  }
}
