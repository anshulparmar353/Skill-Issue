import '../entities/roadmap.dart';

abstract class RoadmapRepository {

  Future<Roadmap> getRoadmap();
}
