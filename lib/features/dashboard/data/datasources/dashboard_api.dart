import '../../../../core/network/dio_client.dart';
import '../models/dashboard_model.dart';

class DashboardApi {

  final DioClient dioClient;

  DashboardApi(this.dioClient);

  Future<DashboardModel> getDashboardSummary() async {

    final response = await dioClient.dio.get(
      "/dashboard/summary",
    );

    return DashboardModel.fromJson(response.data);
  }
}
