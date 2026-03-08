import '../../domain/entities/roadmap_step.dart';

class RoadmapStepModel extends RoadmapStep {
  RoadmapStepModel({
    required super.title,
    required super.completed,
    required super.description,
  });

  factory RoadmapStepModel.fromJson(Map<String, dynamic> json) {
    return RoadmapStepModel(
      title: json["title"] ?? "",
      completed: json["completed"] ?? false,
      description: json["description"] ?? "",
    );
  }
}
