import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/auth_response_model.dart';

class RegisterApi {

  final DioClient dioClient;

  RegisterApi(this.dioClient);

  Future<AuthResponseModel> register({
    required String name,
    required String email,
    required String password,
  }) async {

    final response = await dioClient.dio.post(
      ApiEndpoints.register,
      data: {
        "name": name,
        "email": email,
        "password": password,
      },
    );

    return AuthResponseModel.fromJson(response.data);
  }
}
