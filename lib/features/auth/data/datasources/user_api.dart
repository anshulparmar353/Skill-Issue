import 'package:skill_issue/features/auth/data/models/auth_response_model.dart';

import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';

class UserApi {

  final DioClient dioClient;

  UserApi(this.dioClient);

  Future<AuthResponseModel> getCurrentUser() async {

    final response = await dioClient.dio.get(
      ApiEndpoints.currentUser,
    );

    return AuthResponseModel.fromJson(response.data);
  }
}
