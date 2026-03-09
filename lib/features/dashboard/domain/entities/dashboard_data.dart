import 'package:equatable/equatable.dart';

class DashboardData extends Equatable {

  final int totalSkills;
  final int beginner;
  final int intermediate;
  final int advanced;
  final int roadmapCompletion;

  const DashboardData({
    required this.totalSkills,
    required this.beginner,
    required this.intermediate,
    required this.advanced,
    required this.roadmapCompletion,
  });

  @override
  List<Object?> get props => [totalSkills, beginner, intermediate, advanced, roadmapCompletion];
}
