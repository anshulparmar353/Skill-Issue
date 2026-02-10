import 'package:flutter/material.dart';
import 'package:skill_issue/core/di/service_locator.dart';
import 'package:skill_issue/core/storage/hive_service.dart';
import 'package:skill_issue/core/routes/app_go_router.dart';
import 'package:skill_issue/shared/theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveService.init();
  await init();                                              

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false, 
      themeMode: ThemeMode.system,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      routerConfig: AppGoRouter.routes,
    );
  }
}
