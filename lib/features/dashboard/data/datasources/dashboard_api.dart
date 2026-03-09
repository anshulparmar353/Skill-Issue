import 'package:dio/dio.dart';
import 'package:skill_issue/core/errors/exceptions.dart';
import 'package:skill_issue/core/network/api_endpoints.dart';

import '../../../../core/network/dio_client.dart';
import '../models/dashboard_model.dart';

class DashboardApi {
  final DioClient dioClient;

  DashboardApi(this.dioClient);

  Future<DashboardModel> getDashboardSummary() async {
    try {
      final response = await dioClient.dio.get(ApiEndpoints.dashboard);

      return DashboardModel.fromJson(response.data);
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
