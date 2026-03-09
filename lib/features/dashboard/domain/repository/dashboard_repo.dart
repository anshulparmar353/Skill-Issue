import 'package:dartz/dartz.dart';
import 'package:skill_issue/core/errors/failures.dart';

import '../entities/dashboard_data.dart';

abstract class DashboardRepository {

  Future<Either<Failure,DashboardData>> getDashboardData();
}
