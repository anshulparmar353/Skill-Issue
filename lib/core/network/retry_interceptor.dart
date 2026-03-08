import 'package:dio/dio.dart';

class RetryInterceptor extends Interceptor {

  final Dio dio;

  RetryInterceptor(this.dio);

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {

    int retryCount = err.requestOptions.extra["retry"] ?? 0;

    if (retryCount < 3 &&
        err.type == DioExceptionType.connectionError) {

      retryCount++;

      err.requestOptions.extra["retry"] = retryCount;

      final response = await dio.fetch(err.requestOptions);

      return handler.resolve(response);
    }

    handler.next(err);
  }
}