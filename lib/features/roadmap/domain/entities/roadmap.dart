import 'roadmap_step.dart';

class Roadmap {
  final String role;
  final int completion;
  final List<RoadmapStep> steps;

  Roadmap({
    required this.role,
    required this.completion,
    required this.steps,
  });
}
