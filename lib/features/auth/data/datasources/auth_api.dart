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

    final response = await dioClient.dio.post(
      ApiEndpoints.login,
      data: {
        "email": email,
        "password": password,
      },
    );

    return AuthResponseModel.fromJson(response.data);
  }
}
