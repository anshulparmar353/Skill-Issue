import 'package:skill_issue/features/roadmap/data/datasources/roadmap_api.dart';
import 'package:skill_issue/features/roadmap/domain/repository/roadmap_repo.dart';

import '../../domain/entities/roadmap.dart';

class RoadmapRepoImpl implements RoadmapRepository {

  final RoadmapApi api;

  RoadmapRepoImpl(this.api);

  @override
  Future<Roadmap> getRoadmap() async {

    try {

      final roadmap = await api.getRoadmap();

      return roadmap;

    } catch (e) {

      throw Exception("Failed to load roadmap");
    }
  }
}
