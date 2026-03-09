import 'package:dio/dio.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/network/api_endpoints.dart';
import 'package:skill_issue/core/network/dio_client.dart';
import 'package:skill_issue/features/profile/data/models/profile_model.dart';

class ProfileApi {
  final DioClient dio;

  ProfileApi(this.dio);

  Future<ProfileModel> getProfile() async {
    try {
      final res = await dio.dio.get(ApiEndpoints.profile);

      return ProfileModel.fromJson(res.data["user"]);
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

  Future<ProfileModel> updateProfile({required String name}) async {
    try {
      final res = await dio.dio.put(ApiEndpoints.updateProfile, data: {"name": name});

      return ProfileModel.fromJson(res.data);
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
