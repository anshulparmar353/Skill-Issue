import 'package:dio/dio.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/features/roadmap/data/models/roadmap_model.dart';

import '../../../../core/network/dio_client.dart';
import 'package:skill_issue/core/network/api_endpoints.dart';

class RoadmapApi {
  final DioClient dio;

  RoadmapApi(this.dio);

  Future<RoadmapModel> getRoadmap(String roleId) async {
    try {
      final res = await dio.dio.get(
        ApiEndpoints.roadmap,
        queryParameters: {"roleId": roleId},
      );

      return RoadmapModel.fromJson(res.data);
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
