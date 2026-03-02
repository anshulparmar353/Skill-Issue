import '../../domain/entities/roadmap_step.dart';

class RoadmapStepModel extends RoadmapStep {

  RoadmapStepModel({
    required super.id,
    required super.title,
    required super.completed,
  });

  factory RoadmapStepModel.fromJson(Map<String, dynamic> json) {

    return RoadmapStepModel(
      id: json["id"].toString(),
      title: json["title"] ?? "",
      completed: json["completed"] ?? false,
    );
  }
}
