import 'package:skill_issue/features/dashboard/data/datasources/dashboard_api.dart';
import 'package:skill_issue/features/dashboard/domain/repository/dashboard_repo.dart';
import '../../domain/entities/dashboard_data.dart';


class DashboardRepoImpl implements DashboardRepository {

  final DashboardApi api;

  DashboardRepoImpl(this.api);

  @override
  Future<DashboardData> getDashboardData() async {

    try {

      final dashboard = await api.getDashboardSummary();

      return dashboard;

    } catch (e) {

      throw Exception("Failed to load dashboard data");
    }
  }
}
