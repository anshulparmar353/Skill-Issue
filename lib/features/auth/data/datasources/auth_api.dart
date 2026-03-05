import 'package:dio/dio.dart';
import 'package:skill_issue/core/errors/exceptions.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_response_model.dart';

class AuthApi {

  final DioClient dioClient;

  AuthApi(this.dioClient);

  Future<AuthResponseModel> login({
    required String email,
    required String password,
  }) async {

    try {
      final response = await dioClient.dio.post(
        ApiEndpoints.login,
        data: {
          "email": email,
          "password": password,
        },
      );
      
      return AuthResponseModel.fromJson(response.data);
    } on DioException catch (e) {
      if (e.type == DioExceptionType.connectionTimeout ||
          e.type == DioExceptionType.connectionError) {
        throw NetworkException();
      } else {
        throw ServerException();
      }
    } catch (_) {
      throw UnknownException();
    }
  }
}
