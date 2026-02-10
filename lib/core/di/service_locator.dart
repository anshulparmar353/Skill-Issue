import 'package:get_it/get_it.dart';
import 'package:dio/dio.dart';
import '../network/dio_client.dart';
import '../storage/token_storage.dart';

final sl = GetIt.instance;

Future<void> init() async {

  sl.registerLazySingleton(() => Dio());
  
  sl.registerLazySingleton<TokenStorage>(() => TokenStorage());
  sl.registerLazySingleton<DioClient>(() => DioClient(sl(), sl()));

}
