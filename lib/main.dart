import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/core/di/service_locator.dart';
import 'package:skill_issue/core/storage/hive_service.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:skill_issue/features/auth/presentation/bloc/auth_notifier.dart';
import 'package:skill_issue/shared/theme/app_theme.dart';
import 'package:skill_issue/core/routes/app_go_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await init();

  runApp(
    MultiBlocProvider(
      providers: [BlocProvider(create: (_) => getIt<AuthBloc>())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final authBloc = context.read<AuthBloc>();
    final authNotifier = AuthNotifier(authBloc);
    final router = AppGoRouter.createRouter(authNotifier);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: router,
    );
  }
}
