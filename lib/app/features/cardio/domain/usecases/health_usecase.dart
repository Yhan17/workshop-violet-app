import 'package:dartz/dartz.dart';

import '../../../../core/failures/failures.dart';
import '../entities/health_entity.dart';
import '../repositories/health_repository.dart';

abstract class HealthUsecase {
  final HealthRepository repository;
  HealthUsecase({
    required this.repository,
  });

  Future<Either<Failures, Unit>> call(HealthEntity entity) {
    return repository.registerHealth(entity);
  }
}
