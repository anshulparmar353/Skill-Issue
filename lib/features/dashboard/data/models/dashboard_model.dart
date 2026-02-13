import '../../domain/entities/dashboard_data.dart';

class DashboardModel extends DashboardData {

  DashboardModel({
    required super.totalSkills,
    required super.beginner,
    required super.intermediate,
    required super.advanced,
    required super.roadmapCompletion,
  });

  factory DashboardModel.fromJson(Map<String, dynamic> json) {

    return DashboardModel(
      totalSkills: json["total_skills"] ?? 0,
      beginner: json["beginner"] ?? 0,
      intermediate: json["intermediate"] ?? 0,
      advanced: json["advanced"] ?? 0,
      roadmapCompletion: json["roadmap_completion"] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "total_skills": totalSkills,
      "beginner": beginner,
      "intermediate": intermediate,
      "advanced": advanced,
      "roadmap_completion": roadmapCompletion,
    };
  }
}
