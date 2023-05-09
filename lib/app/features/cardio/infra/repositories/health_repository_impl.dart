import 'package:dartz/dartz.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import '../../domain/entities/health_entity.dart';
import '../dtos/health_dto.dart';

import '../../../../core/failures/failures.dart';
import '../../../../core/http/backend_http_client.dart';
import '../../domain/repositories/health_repository.dart';

class HealthRepositoryImpl extends HealthRepository {
  final BackendHttpClient client;
  HealthRepositoryImpl({
    required this.client,
  });

  @override
  Future<Either<Failures, Unit>> registerHealth(HealthEntity health) async {
    try {
      await client.post(
        '/health/create',
        data: HealthDto.fromEntity(health).toMap(),
      );

      return right(unit);
    } catch (_) {
      return left(Failures.serverFailures);
    }
  }

  @override
  Future<Either<Failures, Unit>> registerLatLong(
    int userId,
    double latitude,
    double longitude,
  ) async {
    try {
      await client.post(
        'user/update/$userId',
        data: {
          'latitude': latitude,
          'longitude': longitude,
        },
      );

      return right(unit);
    } catch (_) {
      return left(Failures.serverFailures);
    }
  }
}
