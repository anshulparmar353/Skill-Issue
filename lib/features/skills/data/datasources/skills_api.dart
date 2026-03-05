import 'package:dio/dio.dart';
import 'package:skill_issue/core/errors/exceptions.dart';

import '../../../../core/network/dio_client.dart';
import '../models/skill_model.dart';

class SkillsApi {
  final DioClient dio;

  SkillsApi(this.dio);

  Future<List<SkillModel>> getSkills() async {
    try {
      final res = await dio.dio.get("/users/skills");
      
      return (res.data as List).map((e) => SkillModel.fromJson(e)).toList();
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

  Future<void> addSkill({required String name}) async {
    try {
      await dio.dio.post("/users/skills", data: {"name": name});
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

  Future<void> deleteSkill(String skillId) async {
    try {
      await dio.dio.delete("/users/skills/$skillId");
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
