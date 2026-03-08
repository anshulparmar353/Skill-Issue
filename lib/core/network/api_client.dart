import 'package:dio/dio.dart';
import 'package:skill_issue/core/network/api_endpoints.dart';
import 'package:skill_issue/core/network/dio_interceptor.dart';
import 'package:skill_issue/core/network/retry_interceptor.dart';

class ApiClient {
  final Dio dio;

  ApiClient()
      : dio = Dio(
          BaseOptions(
            baseUrl: ApiEndpoints.baseUrl,
            connectTimeout: const Duration(seconds: 10),
            receiveTimeout: const Duration(seconds: 10),
          ),
        ) {
    dio.interceptors.add(GlobalDioInterceptor());
    dio.interceptors.add(RetryInterceptor(dio));
  }
}