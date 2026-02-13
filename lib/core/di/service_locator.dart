import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import 'package:skill_issue/features/dashboard/data/datasources/dashboard_api.dart';
import 'package:skill_issue/features/dashboard/data/repository_impl/dashboard_repo_impl.dart';
import 'package:skill_issue/features/dashboard/domain/repository/dashboard_repo.dart';
import 'package:skill_issue/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:skill_issue/features/profile/data/datasources/profile_api.dart';
import 'package:skill_issue/features/profile/data/repository_impl/profile_repo_impl.dart';
import 'package:skill_issue/features/profile/domain/repository/profile_repo.dart';
import 'package:skill_issue/features/profile/domain/usecases/get_profile_usecase.dart';
import 'package:skill_issue/features/profile/domain/usecases/update_profile_usecase.dart';
import 'package:skill_issue/features/skills/data/datasources/skills_api.dart';
import 'package:skill_issue/features/skills/data/repository_impl/skills_repo_impl.dart';
import 'package:skill_issue/features/skills/domain/repository/skills_repo.dart';
import 'package:skill_issue/features/skills/domain/usecases/add_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/delete_skill_usecase.dart';
import 'package:skill_issue/features/skills/domain/usecases/get_skills_usecase.dart';
import '../network/dio_client.dart';
import '../storage/token_storage.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerLazySingleton(() => Dio());

  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage());
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt(), getIt()));

  /// Profile

  getIt.registerLazySingleton(() => ProfileApi(getIt()));

  getIt.registerLazySingleton<ProfileRepository>(
    () => ProfileRepoImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetProfileUseCase(getIt()));

  getIt.registerLazySingleton(() => UpdateProfileUseCase(getIt()));

  /// Dashboard

  getIt.registerLazySingleton(() => DashboardApi(getIt()));

  getIt.registerLazySingleton<DashboardRepository>(
    () => DashboardRepoImpl(getIt()),
  );

  getIt.registerLazySingleton(() => GetDashboardDataUseCase(getIt()));

  /// Skills

  getIt.registerLazySingleton(() => SkillsApi(getIt()));

  getIt.registerLazySingleton<SkillsRepository>(() => SkillsRepoImpl(getIt()));

  getIt.registerLazySingleton(() => GetSkillsUseCase(getIt()));

  getIt.registerLazySingleton(() => AddSkillUseCase(getIt()));

  getIt.registerLazySingleton(() => DeleteSkillUseCase(getIt()));
}
