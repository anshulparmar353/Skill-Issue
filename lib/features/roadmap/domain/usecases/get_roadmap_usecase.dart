import 'package:skill_issue/features/roadmap/domain/repository/roadmap_repo.dart';

import '../entities/roadmap.dart';

class GetRoadmapUseCase {

  final RoadmapRepository repo;

  GetRoadmapUseCase(this.repo);

  Future<Roadmap> call() {
    return repo.getRoadmap();
  }
}
