import 'package:equatable/equatable.dart';
import 'package:skill_issue/features/dashboard/domain/entities/dashboard_data.dart';

class DashboardState extends Equatable {

  final bool loading;
  final DashboardData? data;
  final String? error;

  const DashboardState({
    required this.loading,
    this.data,
    this.error,
  });

  factory DashboardState.initial() => DashboardState(loading: false);

  DashboardState copyWith({
    bool? loading,
    DashboardData? data,
    String? error,
  }) {
    return DashboardState(
      loading: loading ?? this.loading,
      data: data ?? this.data,
      error: error,
    );
  }

  @override
  List<Object?> get props => [loading, data, error];
}
