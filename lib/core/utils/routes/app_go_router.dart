import 'package:go_router/go_router.dart';
import 'package:skill_issue/features/auth/presentation/pages/forgot_password.dart';
import 'package:skill_issue/features/auth/presentation/pages/login_screen.dart';
import 'package:skill_issue/features/auth/presentation/pages/signup_screen.dart';
import 'package:skill_issue/features/start_page/presentation/pages/start_screen.dart';
import 'package:skill_issue/core/utils/routes/navigation_services.dart';

part 'app_routes.dart';

class AppGoRouter {
  static GoRouter routes = GoRouter(
    navigatorKey: NavigationServices.navigationKey,
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
