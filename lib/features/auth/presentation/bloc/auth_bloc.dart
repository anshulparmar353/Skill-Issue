import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/auth/domain/usecases/login_usecase.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_event.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LoginUseCase loginUseCase;

  AuthBloc(this.loginUseCase) : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
    on<LogoutRequested>(_onLogoutRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());

    try {
      final user = await loginUseCase(event.email, event.password);

      emit(Authenticated(user: user));
    } catch (e) {
      emit(AuthError(message: "Login failed"));
    }
  }

  void _onLogoutRequested(LogoutRequested event, Emitter<AuthState> emit) {
    emit(Unauthenticated());
  }
}
