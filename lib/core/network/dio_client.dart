import 'package:dio/dio.dart';
import '../storage/token_storage.dart';
import 'api_endpoints.dart';

class DioClient {
  final Dio dio;
  final TokenStorage tokenStorage;

  DioClient(this.dio, this.tokenStorage) {
    dio.options = BaseOptions(
      baseUrl: ApiEndpoints.baseUrl,
      connectTimeout: const Duration(seconds: 30),
      receiveTimeout: const Duration(seconds: 30),
      headers: {"Content-Type": "application/json"},
    );

    dio.interceptors.add(
      InterceptorsWrapper(onRequest: _onRequest, onError: _onError),
    );
  }

  Future<void> _onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenStorage.getAccessToken();

    if (token != null) {
      options.headers["Authorization"] = "Bearer $token";
    }

    handler.next(options);
  }

  Future<void> _onError(
    DioException err,
    ErrorInterceptorHandler handler,
  ) async {
    if (err.response?.statusCode == 401) {
      try {
        final refreshToken = await tokenStorage.getRefreshToken();

        final response = await dio.post(
          ApiEndpoints.refresh,
          data: {"refresh_token": refreshToken},
        );

        final newAccess = response.data["access_token"];
        final newRefresh = response.data["refresh_token"];

        await tokenStorage.saveTokens(access: newAccess, refresh: newRefresh);

        /// Retry original request
        final cloned = await dio.request(
          err.requestOptions.path,
          options: Options(
            method: err.requestOptions.method,
            headers: {"Authorization": "Bearer $newAccess"},
          ),
          data: err.requestOptions.data,
          queryParameters: err.requestOptions.queryParameters,
        );

        return handler.resolve(cloned);
      } catch (e) {
        await tokenStorage.clear();
      }
    }

    handler.next(err);
  }
}
