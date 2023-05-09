import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../repositories/health_repository.dart';

abstract class LatLongUsecase {
  final HealthRepository repository;
  LatLongUsecase({
    required this.repository,
  });

  Future<Either<Failures, Unit>> call(
    int userId,
    double latitude,
    double longitude,
  ) {
    return repository.registerLatLong(
      userId,
      latitude,
      longitude,
    );
  }
}
