import 'package:go_router/go_router.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_notifier.dart';
import 'package:skill_issue/features/auth/presentation/pages/forgot_password.dart';
import 'package:skill_issue/features/auth/presentation/pages/login_screen.dart';
import 'package:skill_issue/features/auth/presentation/pages/signup_screen.dart';
import 'package:skill_issue/features/dashboard/presentation/pages/dashboard_page.dart';
import 'package:skill_issue/features/home/presentation/pages/home_page.dart';
import 'package:skill_issue/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:skill_issue/features/profile/presentation/pages/profile_page.dart';
import 'package:skill_issue/features/quiz/presentation/pages/quiz_page.dart';
import 'package:skill_issue/features/roadmap/presentation/pages/roadmap_page.dart';
import 'package:skill_issue/features/add_skills/presentation/pages/add_skill.dart';

part 'app_routes.dart';

class AppGoRouter {
  static GoRouter createRouter(AuthNotifier authNotifier) {
    return GoRouter(
      initialLocation: AppRoutes.splashScreen,

      refreshListenable: authNotifier,

      redirect: (context, state) {
        final loggedIn = authNotifier.isAuthenticated;
        final loggingIn = state.matchedLocation == AppRoutes.loginScreen;
        final isSplash = state.matchedLocation == AppRoutes.splashScreen;

        if (isSplash) return null;

        if (!loggedIn && !loggingIn) {
          return AppRoutes.loginScreen;
        }

        if (loggedIn && loggingIn) {
          return AppRoutes.homeScreen;
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
          path: AppRoutes.addSkillsScreen,
          builder: (context, state) => AddSkill(),
        ),

        GoRoute(
          path: AppRoutes.quizScreen,
          builder: (context, state) => QuizPage(),
        ),

        ShellRoute(
          builder: (context, state, child) {
            return HomePage(child: child);
          },

          routes: [
            GoRoute(
              path: AppRoutes.dashboardScreen,
              builder: (context, state) => DashboardPage(),
            ),

            GoRoute(
              path: AppRoutes.skillScreen,
              builder: (context, state) => DashboardPage(),
            ),

            GoRoute(
              path: AppRoutes.roadmapScreen,
              builder: (context, state) => RoadmapPage(),
            ),

            GoRoute(
              path: AppRoutes.profileScreen,
              builder: (context, state) => ProfilePage(),
            ),
          ],
        ),

        GoRoute(
          path: AppRoutes.profileEditScreen,
          builder: (context, state) => EditProfilePage(currentName: state.extra as String),
        ),
      ],
    );
  }
}
