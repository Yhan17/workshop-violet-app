import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/health_entity.dart';

abstract class HealthRepository {
  Future<Either<Failures, Unit>> registerHealth(HealthEntity health);
  Future<Either<Failures, Unit>> registerLatLong(
    int userId,
    double latitude,
    double longitude,
  );
}
