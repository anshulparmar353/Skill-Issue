import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../storage/token_storage.dart';

final getIt = GetIt.instance;

Future<void> init() async {

  getIt.registerLazySingleton(() => Dio());
  
  getIt.registerLazySingleton<TokenStorage>(() => TokenStorage());
  getIt.registerLazySingleton<DioClient>(() => DioClient(getIt(), getIt()));

}
