import '../../domain/entities/roadmap.dart';
import 'roadmap_step_model.dart';

class RoadmapModel extends Roadmap {

  RoadmapModel({
    required super.role,
    required super.completion,
    required super.steps,
  });

  factory RoadmapModel.fromJson(Map<String, dynamic> json) {

    return RoadmapModel(
      role: json["role"] ?? "",
      completion: json["completion"] ?? 0,
      steps: (json["steps"] as List)
          .map((e) => RoadmapStepModel.fromJson(e))
          .toList(),
    );
  }
}
