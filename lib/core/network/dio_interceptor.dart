import 'package:dio/dio.dart';

class GlobalDioInterceptor extends Interceptor {

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {

    switch (err.type) {

      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
        handler.reject(
          err.copyWith(error: "Request Timeout"),
        );
        break;

      case DioExceptionType.connectionError:
        handler.reject(
          err.copyWith(error: "No Internet Connection"),
        );
        break;

      default:
        if (err.response?.statusCode == 401) {
          handler.reject(err.copyWith(error: "Unauthorized"));
        } else if (err.response?.statusCode == 500) {
          handler.reject(err.copyWith(error: "Server Error"));
        } else {
          handler.next(err);
        }
    }
  }
}