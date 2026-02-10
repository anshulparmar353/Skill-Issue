import 'package:flutter/foundation.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_state.dart';

class AuthNotifier extends ChangeNotifier {

  final AuthBloc authBloc;

  AuthNotifier(this.authBloc) {
    authBloc.stream.listen((_) {
      notifyListeners();
    });
  }

  bool get isAuthenticated =>
      authBloc.state is Authenticated;
}
