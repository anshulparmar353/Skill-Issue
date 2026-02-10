import 'package:go_router/go_router.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_notifier.dart';
import 'package:skill_issue/features/auth/presentation/pages/forgot_password.dart';
import 'package:skill_issue/features/auth/presentation/pages/login_screen.dart';
import 'package:skill_issue/features/auth/presentation/pages/signup_screen.dart';
import 'package:skill_issue/features/start_page/presentation/pages/start_screen.dart';

part 'app_routes.dart';

class AppGoRouter {

  static GoRouter createRouter(AuthNotifier authNotifier) {

    return GoRouter(
      initialLocation: AppRoutes.splashScreen,

      refreshListenable: authNotifier,

      redirect: (context, state) {

        final loggedIn = authNotifier.isAuthenticated;
        final loggingIn = state.matchedLocation == "/login";
        final isSplash = state.matchedLocation == "/splash";

        if (isSplash) return null;

        if (!loggedIn && !loggingIn) {
          return "/login";
        }

        if (loggedIn && loggingIn) {
          return "/dashboard";
        }

        return null;
      },

      routes: [
        GoRoute(
          path: AppRoutes.loginScreen,
          builder: (context, state) => LoginScreen(),
        ),

        GoRoute(
          path: AppRoutes.signupScreen,
          builder: (context, state) => SignupScreen(),
        ),

        GoRoute(
          path: AppRoutes.forgotPasswordScreen,
          builder: (context, state) => ForgotPassword(),
        ),

        GoRoute(
          path: AppRoutes.startscreen,
          builder: (context, state) => StartScreen(),
        ),
      ],
    );
  }
}
