import 'package:dartz/dartz.dart';
import '../entities/user_entity.dart';

import '../../../../core/failures/failures.dart';

abstract class UserRepository {
  Future<Either<Failures, UserEntity>> fetchUser(String name);
  /// Apenas demonstrativo
  Future<Either<Failures, List<UserEntity>>> fetchUsers();
}
