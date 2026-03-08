import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';
import 'package:skill_issue/features/roadmap/domain/entities/roadmap.dart';

abstract class RoadmapRepository {

  Future<Either<Failure, Roadmap>> getRoadmap(String roleId);
}
