import '../../../../core/network/dio_client.dart';
import '../../../../core/network/api_endpoints.dart';
import '../models/user_model.dart';

class UserApi {

  final DioClient dioClient;

  UserApi(this.dioClient);

  Future<UserModel> getCurrentUser() async {

    final response = await dioClient.dio.get(
      ApiEndpoints.currentUser,
    );

    return UserModel.fromJson(response.data);
  }
}
