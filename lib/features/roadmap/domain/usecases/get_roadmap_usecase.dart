import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/roadmap/domain/entities/roadmap.dart';
import 'package:skill_issue/features/roadmap/domain/repository/roadmap_repo.dart';


class GetRoadmapUseCase {

  final RoadmapRepository repo;

  GetRoadmapUseCase(this.repo);

  Future<Either<Failure, Roadmap>> call(String roleId) {
    return repo.getRoadmap(roleId);
  }
}
