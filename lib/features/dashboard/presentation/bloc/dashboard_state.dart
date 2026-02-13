import 'package:skill_issue/features/dashboard/domain/entities/dashboard_data.dart';

class DashboardState {

  final bool loading;
  final DashboardData? data;
  final String? error;

  DashboardState({
    required this.loading,
    this.data,
    this.error,
  });

  factory DashboardState.initial() =>
      DashboardState(loading: false);
}
