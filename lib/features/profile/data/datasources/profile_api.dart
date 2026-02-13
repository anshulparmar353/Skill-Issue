import 'package:skill_issue/core/network/dio_client.dart';
import 'package:skill_issue/features/profile/data/models/profile_model.dart';

class ProfileApi {

  final DioClient dio;

  ProfileApi(this.dio);

  Future<ProfileModel> getProfile() async {

    final res = await dio.dio.get("/users/me");

    return ProfileModel.fromJson(res.data["user"]);
  }

  Future<ProfileModel> updateProfile({
    required String name,
  }) async {

    final res = await dio.dio.put(
      "/users/update",
      data: {
        "name": name,
      },
    );

    return ProfileModel.fromJson(res.data);
  }
}
